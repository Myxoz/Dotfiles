if status is-interactive
    # Commands to run in interactive sessions can go here
end
alias nano=nvim
alias rtw="sudo efibootmgr --bootnext 0000 && sudo reboot"
alias mount_old="sudo mount /dev/nvme0n1p6 /old --mkdir"
alias mount_win="sudo mount /dev/nvme0n1p4 /win --mkdir"
alias ssh="TERM=xterm command ssh"
alias sync_life="scp ~/code/php/life_api/_api.php myxoz:~/myxoz.de/life/_api.php"
alias countcodelines="find . -type f -name '*.kt' -print0 | xargs -0 cat | wc -l"
alias resyncbank="cd ~/code/nodejs/banking && node index.js"
alias adb="/home/blaze/Android/Sdk/platform-tools/adb"
alias apktool="java -jar ~/Pownloads/apktool.jar"
alias apksigner="/home/blaze/Android/Sdk/build-tools/36.1.0/apksigner"
        
function sshcat
    if test (count $argv) -ne 1
        echo "Usage: sshcat user@host:/path/to/file"
        return 1
    end

    set tmpfile (mktemp)
    scp $argv $tmpfile
    cat $tmpfile
    rm $tmpfile
end

function poff
    read -P "Resync bank before poweroff? (y/N): " -l choice
    if test "$choice" = "N"
        poweroff
    else if test "$choice" = "y"
        resyncbank && poweroff
    else
        echo "Invalid choice. Cancelled."
    end
end

function sshvim
    if test (count $argv) -ne 1
        echo "Usage: sshnvim user@host:/path/to/file"
        return 1
    end

    set remote $argv[1]

    set filename (basename $remote)
    set ext (string match -r '\.[^.]+$' $filename)

    set tmpfile (mktemp --suffix=$ext)

    scp $remote $tmpfile
    nvim $tmpfile
    scp $tmpfile $remote

    rm $tmpfile
end

function runsudo --description 'Run last command using sudo'
	set last_cmd (history | head -n1)
	eval "command sudo $last_cmd"
end

source "$HOME/.cargo/env.fish" 

starship init fish | source
zoxide init fish | source
