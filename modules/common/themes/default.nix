{ config, pkgs, ...}:
{
  # Fonts
  fonts.fontDir.enable = true;
  fonts = {
    packages = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts.fira-mono
      nerd-fonts.symbols-only
      font-awesome 
      google-fonts 
      ipafont
    ];
  };

  # Flatpak font compatibility
  system.fsPackages = [ pkgs.bindfs ];
 
 environment.systemPackages = [ pkgs. adwaita-icon-theme ];

  fileSystems = let
    mkRoSymBind = path: {
      device = path;
      fsType = "fuse.bindfs";
      options = [ "ro" "resolve-symlinks" "x-gvfs-hide" ];
    };
    aggregated = pkgs.buildEnv {
        name = "system-fonts-and-icons";
        paths = config.fonts.packages ++ (with pkgs; [
          # Add your cursor themes and icon packages here
          bibata-cursors
          # etc.
        ]);
        pathsToLink = [ "/share/fonts" "/share/icons" ];
    };
  in {
    "/usr/share/fonts" = mkRoSymBind "${aggregated}/share/fonts";
    "/usr/share/icons" = mkRoSymBind "${aggregated}/share/icons";
  };

  home-manager.users.sayid = { pkgs, ... }: {
    fonts.fontconfig.enable = true;
#    home.pointerCursor = {
#      gtk.enable = true;
#      package = pkgs.bibata-cursors;
#      name = "Bibata-Modern-Ice";
#      size = 24;
#    };
#    home.sessionVariables = {
#      XCURSOR_SIZE = 24;
#    };
    gtk = {
      enable = true;
      font = {
        name = "Quicksand";
        size = 11;
      };
      iconTheme = {
        name = "Papirus-dark";
        package = pkgs.papirus-icon-theme;
      };
      cursorTheme = {
        name = "Bibata-Modern-Ice";
        package = pkgs.bibata-cursors;
        size = 24;
      };
      theme = {
        name = "Matcha-dark-azul";
        package = pkgs.matcha-gtk-theme.override {
          colorVariants = ["dark"];
          themeVariants = ["azul"];
        };
      };
      gtk3.extraConfig = {
        Settings = ''
          gtk-application-prefer-dark-theme=1
        '';
      };
      gtk4.extraConfig = {
        Settings = ''
          gtk-application-prefer-dark-theme=1
        '';
      };
    };
    dconf.settings = {
      "org/gnome/desktop/background" = {
        picture-uri-dark = "/home/sayid/nixos/bg/Japan Pond.jpg";
      };
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };
}
