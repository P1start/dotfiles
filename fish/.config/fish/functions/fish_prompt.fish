function fish_prompt --description 'Write out the prompt'
	set -l last_status $status

	# Just calculate this once, to save a few cycles when displaying the prompt
	if not set -q __fish_prompt_hostname
		set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
	end

	set -l normal (set_color normal)

	# Hack; fish_config only copies the fish_prompt function (see #736)
	if not set -q -g __fish_classic_git_functions_defined
		set -g __fish_classic_git_functions_defined

		function __fish_repaint_user --on-variable fish_color_user --description "Event handler, repaint when fish_color_user changes"
			if status --is-interactive
				commandline -f repaint ^/dev/null
			end
		end
		
		function __fish_repaint_host --on-variable fish_color_host --description "Event handler, repaint when fish_color_host changes"
			if status --is-interactive
				commandline -f repaint ^/dev/null
			end
		end
		
		function __fish_repaint_status --on-variable fish_color_status --description "Event handler; repaint when fish_color_status changes"
			if status --is-interactive
				commandline -f repaint ^/dev/null
			end
		end

		function __fish_repaint_bind_mode --on-variable fish_key_bindings --description "Event handler; repaint when fish_key_bindings changes"
			if status --is-interactive
				commandline -f repaint ^/dev/null
			end
		end

		# initialize our new variables
		if not set -q __fish_classic_git_prompt_initialized
			set -qU fish_color_user; or set -U fish_color_user -o green
			set -qU fish_color_host; or set -U fish_color_host -o cyan
			set -qU fish_color_status; or set -U fish_color_status red
			set -U __fish_classic_git_prompt_initialized
		end
	end

	set -l color_cwd
	set -l prefix
	switch $USER
	case root toor
		if set -q fish_color_cwd_root
			set color_cwd $fish_color_cwd_root
		else
			set color_cwd $fish_color_cwd
		end
		set suffix '#'
	case '*'
		set color_cwd $fish_color_cwd
		set suffix '>'
	end

	set -l prompt_status
	if test $last_status -ne 0
        set prompt_status (set_color red)'!'
    else
		set prompt_status ' '
	end

	set -l mode_str
	switch "$fish_key_bindings"
	case '*_vi_*' '*_vi'
		# possibly fish_vi_key_bindings, or custom key bindings
		# that includes the name "vi"
		set mode_str (
			echo -n " "
			switch $fish_bind_mode
			case default
				set_color --bold --background red white
				echo -n "[N]"
			case insert
				set_color --bold green
				echo -n "[I]"
			case visual
				set_color --bold magenta
				echo -n "[V]"
			end
			set_color normal
		)
	end

    set -l git_prompt
    set -g is_git_repo
    if git branch >/dev/null 2>&1
        set is_git_repo yes
    end
    if test -n "$is_git_repo"; or pijul status >/dev/null 2>&1
        set -l colour
        set -l IFS
        set -l git_status (git status 2>/dev/null)
        set -l pijul_status (pijul status 2>/dev/null)
        if echo $git_status | grep Changes\ not\ staged >/dev/null; or echo $pijul_status | grep Changes\ not\ yet\ recorded >/dev/null
            set colour (set_color -o red)
        else if echo $git_status | grep Changes\ to\ be\ committed >/dev/null
            set colour (set_color green)
        else
            set colour (set_color yellow)
        end
        set -l git_untracked
        if echo $git_status | grep Untracked >/dev/null; or echo $pijul_status | grep Untracked >/dev/null
            set git_untracked '*'
        end
        set -l prompt_pre
        if test -n "$is_git_repo"
            set prompt_pre (__fish_git_prompt ' '|sed -e 's/ //g')
        else
            set prompt_pre (pijul branches | grep '^\*' | awk '{print $2}')
        end
        set git_prompt ' ' $colour $prompt_pre (set_color yellow) $git_untracked
    end

    set -l jobs_indicator
    for i in (jobs | tail -n +1)
        set -l job_color green
        if echo $i | grep stopped >/dev/null
            set job_color yellow
        end
        set jobs_indicator $jobs_indicator (set_color $job_color)+
    end

	#echo -n -s $jobs_indicator $prompt_status (set_color $fish_color_user) "$USER" $normal ' ' (set_color $color_cwd) (prompt_pwd) $normal $git_prompt $normal $mode_str " $suffix "
    echo -n -s $jobs_indicator $prompt_status (set_color $color_cwd) (prompt_pwd) $normal $git_prompt ' ' (set_color normal)
end
