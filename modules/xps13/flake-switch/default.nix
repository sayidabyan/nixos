{...}:

{
  home-manager.users.sayid = { ... }: {
    programs = {
        zsh = {
            shellAliases = {
                nixos-upgrade = "sudo nixos-rebuild switch --flake ~/nixos#xps13";
                nixos-upgrade-ext = "sudo nixos-rebuild switch --flake .#xps13 --build-host sayid@100.112.119.112 --sudo";
            };
        };
    };
  };
}
