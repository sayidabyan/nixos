{ config, pkgs, ...}:

{
  # Fonts
  fonts.fontDir.enable = true;
  fonts = {
    packages = with pkgs; [
      #nerd-fonts.fira-code
      #nerd-fonts.symbols-only
      nerdfonts
      font-awesome 
      google-fonts 
      ipafont
    ];
  };

  # Flatpak font compatibility
  system.fsPackages = [ pkgs.bindfs ];
  fileSystems = let
    mkRoSymBind = path: {
      device = path;
      fsType = "fuse.bindfs";
      options = [ "ro" "resolve-symlinks" "x-gvfs-hide" ];
    };
    aggregatedFonts = pkgs.buildEnv {
      name = "system-fonts";
      paths = config.fonts.packages;
      pathsToLink = [ "/share/fonts" ];
    };
  in {
    # Create an FHS mount to support flatpak host icons/fonts
    "/usr/share/icons" = mkRoSymBind (config.system.path + "/share/icons");
    "/usr/share/fonts" = mkRoSymBind (aggregatedFonts + "/share/fonts");
  };
  home-manager.users.sayid = { pkgs, ... }: {
    fonts.fontconfig.enable = true;
    gtk = {
      enable = true;
      font = {
        name = "Quicksand";
        size = 11;
      };
      iconTheme = {
        name = "Papirus";
        package = pkgs.catppuccin-papirus-folders.override {
          flavor = "mocha";
          accent = "lavender";
        };
      };
      cursorTheme = {
        name = "Bibata-Modern-Ice";
        package = pkgs.bibata-cursors;
        size = 24;
      };
      theme = {
        name = "catppuccin-mocha-lavender-standard";
        package = pkgs.catppuccin-gtk.override {
          accents = ["lavender"];
          size  = "standard";
          variant = "mocha";
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
    qt = {
      enable = true;
      platformTheme.name = "gtk";
      style.name = "gtk2";
    };
    dconf.settings = {
      "org/gnome/desktop/background" = {
        picture-uri-dark = "/home/sayid/nixos/bg/Sakura Festival.jpg";
      };
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };
}
