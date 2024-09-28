{ config, pkgs, callPackage, ... }: 

{
  services.xserver = {
    enable = true;

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        i3blocks
        i3lock
      ];

      extraConfig = ''
        workspace_auto_back_and_forth yes
        popup_during_fullscreen smart
        default_orientation vertical
        for_window [class=".*"] split toggle
      '';

      config = {

        colors = {
          background = "#2e3440";
          focused = {
            background = "#eceff4";
            border = "#4c566a";
            indicator = "#81a1c1";
            text = "#eceff4";
          };
          unfocused = {
            background = "#81a1c1";
            border = "#4c566a";
            indicator = "#8fbcbb";
            text = "#2e3440";
          };
          focusedInactive = {
            background = "#81a1c1";
            border = "#4c566a";
            indicator = "#2e3440";
            text = "#2e3440";
          };
          placeholder = {
            background = "#2e3440";
            border = "#4c566a";
            indicator = "#2e3440";
            text = "#4c566a";
          };
          urgent = {
            background = "#bf616a";
            border = "#4c566a";
            indicator = "#bf616a";
            text = "#eceff4";
          };
        };

        workspaces = {
          ws1 = "1:<span size='large'></span>";
          ws2 = "2:<span size='large'></span>";
          ws3 = "3:<span size='large'></span>";
          ws4 = "4:<span size='large'></span>";
          ws5 = "5:<span size='medium'></span>";
          ws6 = "6:<span size='large'></span>";
          ws7 = "7:<span size='large'></span>";
          ws8 = "8:<span size='large'></span>";
          ws9 = "9:<span size='large'></span>";
          ws10 = "10:<span size='large'>󰺕</span>";
        };

        modes = {
          resize = {
            h = "resize shrink width 10 px or 10 ppt";
            l = "resize grow width 10 px or 10 ppt";
            k = "resize shrink height 10 px or 10 ppt";
            j = "resize grow height 10 px or 10 ppt";

            Escape = "mode default";
            Return = "mode default";
          };
        };

        keybindings = let mod="Mod4"; alt="Mod1"; in with pkgs; {
          XF86AudioPause         = "exec ${playerctl}/bin/playerctl pause";
          XF86AudioNext          = "exec ${playerctl}/bin/playerctl next";
          XF86AudioPrev          = "exec ${playerctl}/bin/playerctl previous";
          XF86AudioLowerVolume   = "exec ${pulseaudioFull}/bin/pactl set-sink-volume 0 -5%";
          XF86AudioRaiseVolume   = "exec ${pulseaudioFull}/bin/pactl set-sink-volume 0 +5%";
          XF86AudioMute          = "exec ${pulseaudioFull}/bin/pactl set-sink-mute 0 toggle";

          "${mod}+Return"        = "exec ${alacritty}/bin/alacritty";
          "${mod}+Shift+less"    = "exec xbacklight -dec 33%";
          "${mod}+Shift+greater" = "exec xbacklight -inc 33%";

          "${mod}+h" = "focus left";
          "${mod}+j" = "focus down";
          "${mod}+k" = "focus up";
          "${mod}+l" = "focus right";

          "${mod}+Shift+h" = "move left";
          "${mod}+Shift+j" = "move down";
          "${mod}+Shift+k" = "move up";
          "${mod}+Shift+l" = "move right";

          "${mod}+Control+h" = "split h";
          "${mod}+Control+v" = "split v";
          "${mod}+Control+space" = "fullscreen toggle";
          "${mod}+Shift+space" = "floating toggle";
          "${mod}+Shift+q" = "kill";
          "${mod}+${alt}+q" = "exit";
          "${mod}+${alt}+c" = "reload";
          "${mod}+${alt}+r" = "restart";

          "${mod}+d"             = "exec --no-startup-id ~/.config/rofi/launchers/type-1/launcher.sh";
          "${mod}+w"             = "exec --no-startup-id ~/.config/rofi/launchers/type-1/window.sh";
          "${mod}+p"             = "exec --no-startup-id ~/.config/rofi/powermenu/type-2/powermenu.sh";
          "${mod}+m"             = "exec --no-startup-id ~/.config/rofi/applets/bin/apps.sh";
          "${mod}+t"             = "exec --no-startup-id ~/.config/rofi/launchers/type-1/task-manager.sh";
          "${mod}+Control+t"     = "exec --no-startup-id ~/.config/task-manager/program/task_manager";
          "Print"                = "exec --no-startup-id ~/.config/rofi/applets/bin/screenshot.sh";

          "${mod}+Control+s" = "layout stacking";
          "${mod}+Control+w" = "layout tabbed";
          "${mod}+Control+e" = "layout toggle split";
          "${mod}+r" = "mode resize";

          "${mod}+1" = "workspace 1";
          "${mod}+2" = "workspace 2";
          "${mod}+3" = "workspace 3";
          "${mod}+4" = "workspace 4";
          "${mod}+5" = "workspace 5";
          "${mod}+6" = "workspace 6";
          "${mod}+7" = "workspace 7";
          "${mod}+8" = "workspace 8";
          "${mod}+9" = "workspace 9";
          "${mod}+0" = "workspace 10";

          "${mod}+Shift+1" = "move container to workspace 1";
          "${mod}+Shift+2" = "move container to workspace 2";
          "${mod}+Shift+3" = "move container to workspace 3";
          "${mod}+Shift+4" = "move container to workspace 4";
          "${mod}+Shift+5" = "move container to workspace 5";
          "${mod}+Shift+6" = "move container to workspace 6";
          "${mod}+Shift+7" = "move container to workspace 7";
          "${mod}+Shift+8" = "move container to workspace 8";
          "${mod}+Shift+9" = "move container to workspace 9";
          "${mod}+Shift+0" = "move container to workspace 10";

          "${mod}+b" = "exec --no-startup-id firefox";
          "${mod}+n" = "exec --no-startup-id apvlv";
          "${mod}+e" = "exec --no-startup-id thunar";
          "${mod}+v" = "exec --no-startup-id codium";
        };

        startup = [
          {
            command = "autotiling";
            always = false;
            notification = false;
          }
          {
            command = "nitrogen --restore";
            always = false;
            notification = false;
          }
          {
            command = "dunst";
            always = false;
            notification = false;
          }
          {
            command = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
            always = false;
            notification = false;
          };
        ];

        bars = [
          {
            position = "top";
            mode = "dock";
            tray_output = "primary";
            tray_padding = 4;
            font = "pango:Hurmit Nerd Font Mono Bold 15";
            separator_symbol = "​";
            strip_workspace_numbers = true;
            status_command = "${pkgs.i3blocks}/bin/i3blocks";
            colors = {
              background = "#2e3440";
              statusline = "#eceff4";
              separator = "#2e3440";
              focused_workspace = {
                background = "#2e3440";
                border = "#81a1c1";
                text = "#eceff4";
              };
              active_workspace = {
                background = "#4c566a";
                border = "#81a1c1";
                text = "#eceff4";
              };
              inactive_workspace = {
                background = "#2e3440";
                border = "#4c566a";
                text = "#81a1c1";
              };
              urgent_workspace = {
                background = "#bf616a";
                border = "#bf616a";
                text = "#eceff4";
              };
            };
          }
        ];
      };
    };
  };
}
