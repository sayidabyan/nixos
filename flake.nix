{
  description = "sayid-nixos flake";

  inputs = {
    home-manager = {
      # url = "github:nix-community/home-manager/release-25.05";
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-bleeding.url = "github:nixos/nixpkgs/master";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable"; # IMPORTANT
    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    editor-integration-nvim = {
      url = "github:aiken-lang/editor-integration-nvim";
      flake = false;
    };
    winresizer-vim = {
      url = "github:simeji/winresizer";
      flake = false;
    };
    zen-browser.url = "github:youwen5/zen-browser-flake";
    apple-silicon-support.url = "github:zzywysm/nixos-asahi";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak";
  };
  outputs = inputs:
    let
      buildSystem = builtins.mapAttrs (device: modules:
        let
          nixpkgs = inputs.nixpkgs;
          home-manager = inputs.home-manager;
          nixos-cosmic = inputs.nixos-cosmic;
          nur = inputs.nur;
          lib = nixpkgs.lib;
          nix-flatpak = inputs.nix-flatpak;
          chaotic = inputs.chaotic;
          modulesInDir = dir: (lib.trivial.pipe dir [
            builtins.readDir
            (lib.attrsets.filterAttrs (key: val: val == "directory"))
            builtins.attrNames
            (builtins.map (name: dir + "/${name}"))
          ]);
        in
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            inherit device;
            username = "sayid";
          };
          modules =
            modulesInDir ./modules/common ++
            modulesInDir (./modules + "/${device}") ++
            [
              ({ pkgs, ... }: {
                nix = {
                  registry.nixpkgs.flake = nixpkgs;
                  settings.experimental-features = [ "nix-command" "flakes" ];
                };
                # Required for nixos-rebuild with flakes
                environment.systemPackages = [ pkgs.git ];
              })
              {
               # nix.settings = {
               #   substituters = [ "https://cosmic.cachix.org/" ];
               #   trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
               # };
              }
              nixos-cosmic.nixosModules.default
              nur.modules.nixos.default
              home-manager.nixosModules.home-manager
              nix-flatpak.nixosModules.nix-flatpak 
              chaotic.nixosModules.nyx-cache
              chaotic.nixosModules.nyx-overlay
              chaotic.nixosModules.nyx-registry
              {

                # make `nix run nixpkgs#nixpkgs` use the same nixpkgs as the one used by this flake.
                nix.registry.nixpkgs.flake = inputs.nixpkgs;

                nixpkgs.overlays = [
                  (final: prev: {
                    unstable = import inputs.nixpkgs-unstable {
                      system = final.system;
                      config.allowUnfree = true;
                    };
                    bleeding = import inputs.nixpkgs-bleeding {
                      system = final.system;
                      config.allowUnfree = true;
                    };
                    vimPlugins =
                      let
                        vimPlugin = name: final.vimUtils.buildVimPlugin {
                          name = name;
                          src = inputs.${name};
                        };
                      in
                      prev.vimPlugins // {
                        editor-integration-nvim = vimPlugin "editor-integration-nvim";
                        winresizer-vim = vimPlugin "winresizer-vim";
                      };
                  })
                ];
              }
            ] ++ modules;
        }
      );
    in
    {
      nixosConfigurations = buildSystem {
        um790 = [
          inputs.nixos-hardware.nixosModules.common-gpu-amd
          inputs.nixos-hardware.nixosModules.common-cpu-amd
          inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
        ];
        xps13 = [
          inputs.nixos-hardware.nixosModules.dell-xps-13-9370
        ];
        amdpc = [
          inputs.nixos-hardware.nixosModules.common-cpu-amd
          inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
        ];
        mbam2 = [
          inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
          inputs.apple-silicon-support.nixosModules.default
        ];
      };
    };
}
