# A rebuild script that commits on a successful build (Fish version)
function rb
    # Exit immediately on error
    function on_error
        echo "❌ Error occurred, aborting."
        popd 2>/dev/null
        exit 1
    end
    trap on_error ERR

    # cd to your config dir
    pushd ~/nixos-config

    # Edit your config
    $EDITOR hosts/{$hostname}/configuration.nix

    # Early return if no changes were detected
    if git diff --quiet '*.nix'
        echo "No changes detected, exiting."
        popd
        exit 0
    end

    # Show your changes
    git diff -U0 '*.nix'

    echo "🚧 NixOS Rebuilding..."

    # Rebuild, output simplified errors, log tracebacks
    sudo nixos-rebuild switch &>nixos-switch.log
    if test $status -ne 0
        cat nixos-switch.log | grep --color error
        on_error
    end

    # Get current generation metadata
    set current (nixos-rebuild list-generations | grep current)

    # Commit all changes with the generation metadata
    git commit -am "$current"

    # Back to where you were
    popd

    # Notify all OK!
    notify-send -e "✅ NixOS Rebuilt OK!" --icon=software-update-available
end
