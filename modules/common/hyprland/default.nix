{pkgs, ...}:
{
  programs.hyprland = {
    enable = true;
  };

  home-manager.users.sayid = {...}: {
    home.packages = with pkgs; [
      grim
      grimblast
      slurp
      satty
      playerctl
      brightnessctl
      nwg-look
      hyprnome
      blueman
    ];

    services.network-manager-applet.enable = true;
    programs.fuzzel = {
      enable = true;
      settings = {
        main = {
          terminal = "/home/sayid/.nix-profile/bin/kitty";
          font = "Quicksand:weight=medium:size=12";
          icon-theme = "Papirus-Dark";
        };
        colors = {
          background="1e1e2eff";
          text="cdd6f4ff";
          match="b4befeff";
          selection="585b70ff";
          selection-match="b4befeff";
          selection-text="cdd6f4ff";
          border="b4befeff";
        };
      };
    };
    services.mako = {
      enable = true;
      font = "Quicksand 12";
      backgroundColor = "#1e1e2e";
      textColor = "#cdd6f4";
      borderColor = "#b4befe";
      borderRadius = 10;
      progressColor = "over #313244";
      defaultTimeout = 5000;
      extraConfig = ''
        [urgency=high]
        border-color=#fab387
      '';
    };

    services.hypridle = {
      enable = true;
      settings = {
        general = {
          after_sleep_cmd = "hyprctl dispatch dpms on";
          ignore_dbus_inhibit = false;
          lock_cmd = "hyprlock";
        };

        listener = [
          {
            timeout = 900;
            on-timeout = "hyprlock";
          }
          {
            timeout = 1200;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
        ];
      };
    };
    programs.hyprlock = {
      enable = true;
      settings = {
        general = {
          hide_cursor = true;
        };
        background = [
          {
            path = "/home/sayid/nixos/bg/Sakura Festival.jpg";
            blur_passes = 3;
            blur_size = 8;
          }
        ];
        input-field = [
          {
            size = "250, 60";
            outline_thickness = 2;
            dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
            dots_spacing = 0.2; # Scale of dots' absolute size, 0.0 - 1.0
            dots_center = true;
            outer_color ="rgba(0, 0, 0, 0)";
            inner_color ="rgba(30, 30, 46, 0.5)";
            font_color = "rgb(200, 200, 200)";
            fade_on_empty = false;
            font_family = "Quicksand";
            placeholder_text = ''
            <span foreground="##ffffff99">Password</span>
            '';
            hide_input = false;
            halign = "center";
            valign = "center";
          }
        ];
        # Hour-Time
        label = [
          {
            text = "$USER";
            color ="rgba(205, 214, 244, .75)";
            font_size = 30;
            font_family = "Quicksand";
            position = "0, 40";
            halign = "center";
            valign = "center";
          }
        ];

      };
    };
    programs.waybar = {
      enable = true;
      package = pkgs.waybar;
      systemd.enable = true;
      settings = { 
        mainBar = {
          position = "top";
          layer = "bottom";
          height = 5;
          margin-top = 0;
          margin-bottom = 0;
          margin-left = 0;
          margin-right = 0;
          modules-left = [ "custom/left" "custom/launcher" "hyprland/window" "custom/right"];
          modules-center = ["custom/altLeft" "hyprland/workspaces" "custom/altRight"];
          modules-right = ["custom/left" "tray" "bluetooth" "pulseaudio" "pulseaudio/slider" "battery" "cpu" "memory" "clock" "custom/right"];
          
          bluetooth = {
            "format" = "";
            "interval" = 5;
            "on-click" = "blueman-manager";
          };

          battery = {
            format = "{icon}  {capacity}%";
            format-icons = [" " " " " " " " " "];
            interval = 5;
            states = {
              "warning" = 30;
              "critical" = 15;
            };
          };

          "hyprland/window" = {
            max-length = 50;
          };

          clock = {
            format = "{:%a %d %b, %H:%M}";
            format-alt = "  {:%H:%M}";
          };

          "hyprland/workspaces" = {
            active-only = false;
            disable-scroll = true;
            format = "{icon}";
            on-click = "activate";
            format-icons = {
              active = "●";
              default = "○";
              special = "⦿";
              urgent = "●";
              sort-by-number = true;
            };
          };

          memory = {
            format = "  {}%";
            format-alt = "  {used} GB";
            interval = 2;
          };

          cpu = {
            format = "  {usage}%";
            format-alt = "  {avg_frequency} GHz";
            interval = 2;
          };

          tray = {
            icon-size = 20;
            spacing = 8;
            reverse-direction = true;
          };

          pulseaudio = {
            format = "{icon}";
            format-muted = " ";
            format-icons = {default = [" " " " " "];};
            scroll-step = 0.25;
            reverse-scrolling = true;
            on-click = "pavucontrol";
            tooltip-format = "{volume}%";
          };

          "pulseaudio/slider" = {
            "min" = 0;
            "max" = 100;
            orientation = "horizontal";
          };

          "custom/launcher" = {
            format = "";
            on-click = "pkill fuzzel || ~/nixos/modules/common/hyprland/fuzzel/fuzzel-powermenu.sh";
            tooltip = "false";
          };
          "custom/left"= {
              "format"= " ";
              "interval" = "once";
              "tooltip"= false;
          };
          "custom/right"= {
              "format"= " ";
              "interval" = "once";
              "tooltip"= false;
          };
          "custom/altLeft"= {
              "format"= " ";
              "interval" = "once";
              "tooltip"= false;
          };
          "custom/altRight"= {
              "format"= " ";
              "interval" = "once";
              "tooltip"= false;
          };
        };
      };
      style = ''
        * {
            border: none;
            border-radius: 0px;
            padding: 0;
            margin: 0;
            min-height: 0px;
            font-family: Quicksand, Firacode Nerd Font;
            font-weight: bold;
            opacity: 1;
        }
        window#waybar {
          background-color: transparent;
        }
        .module {
          margin-top: 3px;
        }
        #workspaces {
          font-size: 15px;
          padding-left: 5px;
          padding-right: 5px;
          padding-bottom: 1px;
          background-color: #1e1e2e;
        }
        #workspaces button {
          color: #b4befe;
          padding-left: 5px;
          padding-right: 5px;
        }
        #workspaces button.urgent {
          color: #fab387;
        }
        #battery, 
        #tray, 
        #pulseaudio,
        #cpu, 
        #memory, 
        #disk, 
        #clock, 
        #custom-launcher, 
        #window,
        #bluetooth
        {
          font-size: 15px;
          color: #cdd6f4;
          padding-left: 5px;
          padding-right: 5px;
          background-color: #1e1e2e;
        }
        #pulseaudio-slider{
          font-size: 15px;
          color: #cdd6f4;
          padding-right: 5px;
          background-color: #1e1e2e;
        }
        #pulseaudio-slider slider {
          min-height: 0px;
          min-width: 0px;
          opacity: 0;
          background-image: none;
          border: none;
          box-shadow: none;
        }
        #pulseaudio-slider trough {
          min-height: 10px;
          min-width: 80px;
          border-radius: 5px;
          background-color: black;
        }
        #pulseaudio-slider highlight {
          min-width: 10px;
          border-radius: 5px;
          background-color: green;
        }

        #bluetooth.connected {
          color: #a6e3a1;
        }

        #bluetooth.off{
          color: #6c7086;
        }

        #battery.charging {
          color: #a6e3a1;
        }
        #batter.warning {
          color: #f9e2af;
        }
        #batter.critical {
          color: #f38ba8;
        }

        #custom-launcher {
          font-size: 18px;
          color: #b4befe;
          font-weight: bold;
        }
        #custom-right, #custom-altRight {
          border-radius: 0px 15px 15px 0px;
          background-color: #1e1e2e;
          margin-right: 10px;
        }

        #custom-left, #custom-altLeft{
          border-radius: 15px 0px 0px 15px;
          background-color: #1e1e2e;
          margin-left: 10px;
        }
      '';
    };

    services.hyprpaper = {
      enable = true;
      settings = {
        preload = [
          "/home/sayid/nixos/bg/Sakura Festival.jpg"
        ];
      };
    };
    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      settings = {
        env =  [
          "ELECTRON_OZONE_PLATFORM_HINT, wayland" 
        ];
        
        input = {
          scroll_factor = "1.5";
          follow_mouse = "1";
          touchpad = {
            natural_scroll = "1";
            scroll_factor = "0.1";
            tap-to-click = false;
            tap-and-drag = false;
            clickfinger_behavior = true;
            disable_while_typing = true;
          };
        };

        gestures = {
          workspace_swipe = true;
          workspace_swipe_cancel_ratio = 0.8;
          workspace_swipe_min_speed_to_force = 3;
          workspace_swipe_distance = 1200;
          workspace_swipe_direction_lock = false;
        };

        cursor = {
          enable_hyprcursor = true;
          no_hardware_cursors = true;
        };
        
        exec-once = [
          # "waybar"
          "hyprctl setcursor Bibata-Modern-Ice 24"
        ];

        general = {
          gaps_in = "3";
          gaps_out = "3";
          border_size = "2";
          "col.active_border" = "rgb(b4befe)";
          layout = "dwindle";
        };

        decoration = {
          rounding = "10";

          blur = {
            enabled = "true";
            size = "8";
            passes = "3";
            popups = "false";
          };
        };

        animations = {
          enabled = true;
          bezier = [ "1, 0.23, 1, 0.32, 1" ];

          animation = [
            "windows, 1, 5, 1"
            "windowsIn, 1, 5, 1, slide"
            "windowsOut, 1, 5, 1, slide"
            "windowsMove, 1, 5, 1, slide"
            "border, 1, 5, default"
            "borderangle, 1, 5, default"
            "workspaces, 1, 5, 1, slide"
          ];
        };
          
        misc = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
          mouse_move_enables_dpms = true;
          new_window_takes_over_fullscreen = 1;
        };
         
        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };
          
        bind = [
          "$mainMod, T, exec, kitty"
          "$mainMod, Q, killactive" 
          # "$mainMod, R, exit"
          "$mainMod, V, togglefloating" 
          "$mainMod, SPACE, exec, pkill fuzzel || fuzzel"
          "$mainMod SHIFT, SPACE, execr, pkill fuzzel || ~/nixos/modules/common/hyprland/fuzzel/fuzzel-calculator.sh"
          "$mainMod CTRL, SPACE, execr, pkill fuzzel || ~/nixos/modules/common/hyprland/fuzzel/fuzzel-powermenu.sh"
          "$mainMod, P, pseudo, # dwindle"
          "$mainMod, Y, togglesplit, # dwindle"
          "$mainMod, M, fullscreen, 1"
          "$mainMod SHIFT, M, fullscreen"
          "$mainMod, TAB, cyclenext"
          "$mainMod, TAB, bringactivetotop"

           # Move focus
          "$mainMod2, H, movefocus, l"
          "$mainMod2, L, movefocus, r"
          "$mainMod2, K, movefocus, u"
          "$mainMod2, J, movefocus, d"

          # Move window
          "$mainMod2 SHIFT, H, movewindow, l"
          "$mainMod2 SHIFT, L, movewindow, r"
          "$mainMod2 SHIFT, K, movewindow, u"
          "$mainMod2 SHIFT, J, movewindow, d"

          # Resize window
          "$mainMod2 CTRL, H, resizeactive, -50 0"
          "$mainMod2 CTRL, L, resizeactive, 50 0"
          "$mainMod2 CTRL, K, resizeactive, 0 -50"
          "$mainMod2 CTRL, J, resizeactive, 0 50"

          # Switch workspaces with mainMod + H/L
          "$mainMod, H, exec, hyprnome -p -n"
          "$mainMod, L, exec, hyprnome"

          # Move active window to a workspace with mainMod + SHIFT + H/L
          "$mainMod SHIFT, H, exec, hyprnome -p -m -n"
          "$mainMod SHIFT, L, exec, hyprnome -m"

          # Special workspace
          # "$mainMod, K, togglespecialworkspace"
          # "$mainMod SHIFT, K, movetoworkspace, special"

          # Screenshot bind
          ", PRINT, exec, grimblast copysave screen"
          "CTRL, PRINT, exec, grimblast copysave area"
          "ALT, PRINT, exec, grimblast save area - | satty -f -"
          "SHIFT, PRINT, exec, grimblast copysave active"

          "$mainMod SHIFT, s, exec, grimblast copysave area"

          # Lock screen
          "$mainMod2, Q, exec, killall hyprlock; hyprlock "
        ];
        # Move/resize windows with mainMod + LMB/RMB and dragging
        bindm = [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];
        binde = [
          # pipewire volume control
          ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+ --limit 1"
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioPrev, exec, playerctl previous"
          ", XF86AudioNext, exec, playerctl next"

          # brightness control
          ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
          ", XF86MonBrightnessUp, exec, brightnessctl set +5%"

          # keyboard backlit
          "$mainMod, XF86MonBrightnessUp, exec, brightnessctl -d kbd_backlight s +20"
          "$mainMod, XF86MonBrightnessDown, exec,  brightnessctl -d kbd_backlight s 20-"
        ];
        windowrulev2 = [
          # "float,class:^(steam)$"
          "float,class:^(nemo)$"
          "float,class:^(org.pulseaudio.pavucontrol)$"
          "float,class:^(.blueman-manager-wrapped)$"
          "fullscreen,class:^steam_app\d+$"
          "monitor 0,class:^steam_app_\d+$"
        ];
      };
    };
  };
}
