function sysstatus --description 'Show system status'
    set -l system_status /git/RembrandtK/rem/bin/system-status.sh
    if test -x $system_status
        echo "🔗 Live dotfiles working! Running system status:"
        $system_status
    else
        echo "System status script not found at $system_status"
    end
end
