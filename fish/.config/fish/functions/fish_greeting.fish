function fish_greeting
    set -l greet
    if [ (random 0 1) -lt 1 ]
        set greet "fortune -s"
    else
        set greet "~/bin/scripts/grook/grook.py"
    end
    eval $greet
    echo
end
