{...}:

{
  home-manager.users.sayid = { ... }: {
    programs = {
        zsh = {
            shellAliases = {
                nixos-upgrade = "sudo nixos-rebuild switch --flake ~/nixos#amdpc";
                nixos-upgrade-ext = "sudo nixos-rebuild switch --flake .#amdpc --build-host sayid@192.168.0.2 --sudo";
            };
        };
    };
  };
}
