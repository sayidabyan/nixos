{
  description = "sayid-nixos flake";

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    nixpkgs.url = "github:nixos/nixpkgs/release-25.11";
    nixpkgs-stable.url = "github:nixos/nixpkgs/release-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-bleeding.url = "github:nixos/nixpkgs/master";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    editor-integration-nvim = {
      url = "github:aiken-lang/editor-integration-nvim";
      flake = false;
    };
    winresizer-vim = {
      url = "github:simeji/winresizer";
      flake = false;
    };
    zen-browser.url = "github:youwen5/zen-browser-flake";
    apollo.url = "github:nil-andreas/apollo-flake";
    apple-silicon-support.url = "github:zzywysm/nixos-asahi";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak";
  };
  outputs = inputs:
    let
      buildSystem = builtins.mapAttrs (device: cfg:
        let
          system = cfg.system;
          modules = cfg.modules;
          nixpkgs = inputs.nixpkgs;
          home-manager = inputs.home-manager;
          nur = inputs.nur;
          lib = nixpkgs.lib;
          nix-flatpak = inputs.nix-flatpak;
          chaotic = inputs.chaotic;
          apollo = inputs.apollo;
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
              nur.modules.nixos.default
              home-manager.nixosModules.home-manager
              nix-flatpak.nixosModules.nix-flatpak 
              chaotic.nixosModules.default
              apollo.nixosModules.${system}.default
              {

                # make `nix run nixpkgs#nixpkgs` use the same nixpkgs as the one used by this flake.
                nix.registry.nixpkgs.flake = inputs.nixpkgs;

                nixpkgs.overlays = [
                  (final: prev: {
                    stable = import inputs.nixpkgs-stable {
                      system = final.stdenv.hostPlatform.system;
                      config.allowUnfree = true;
                    };
                    unstable = import inputs.nixpkgs-unstable {
                      system = final.stdenv.hostPlatform.system;
                      config.allowUnfree = true;
                    };
                    bleeding = import inputs.nixpkgs-bleeding {
                      system = final.stdenv.hostPlatform.system;
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
        um790 = {
          system = "x86_64-linux";
          modules = [
            inputs.nixos-hardware.nixosModules.common-gpu-amd
            inputs.nixos-hardware.nixosModules.common-cpu-amd
            inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
          ];
        };
        amdpc = {
          system = "x86_64-linux";
          modules = [
            inputs.nixos-hardware.nixosModules.common-cpu-amd
            inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
          ];
        };
        mbam2 = {
          system = "aarch64-linux";  # <- arm / Apple Silicon
          modules = [
            inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
            inputs.apple-silicon-support.nixosModules.default
          ];
        };
      };
    };
}
