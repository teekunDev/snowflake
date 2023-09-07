#
#  Waybar home-manager configuration.
#
#  flake.nix
#   └─ ./hosts
#       └─ ./common
#           └─ ./home
#               ├─ home.nix !
#               └─ ./modules
#                   └─ waybar.nix *
#

# TODO: use webnowplaying for media info and control.

{ host, ... }:

let 
  output = with host;
    if hostName == "desktop" then
      [ "DP-2" ]
    else if hostName == "laptop" then
      [ "DP-1" ]
    else [ ];
in
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        position = "top";
        layer = "top";
        output = output;
        margin-top = 0;
        margin-bottom = 0;
        margin-left = 0;
        margin-right = 0;
        modules-left = ["hyprland/workspaces" "cpu" "memory" ];
        modules-center = ["custom/wnp"];
        # TODO: microphone
        modules-right = ["custom/record" "tray" "custom/brightness" "idle_inhibitor" "custom/vpn" "pulseaudio" "clock"];
        clock = {
          format = " {:%H:%M}";
          format-alt = " {:%Y-%m-%d}";
        };
        "hyprland/workspaces" = {
          all-outputs = true;
          on-scroll-up = "hyprctl dispatch workspace -1";
          on-scroll-down = "hyprctl dispatch workspace +1";
          format = "{icon}";
          on-click = "activate";
          format-icons = {
            urgent = "";
            active = "";
            default = "󰧞";
            sort-by-number = true;
          };
        };
        "custom/wnp" = {
          format = "<span>{}</span>";
          interval = 1;
          tooltip = false;
          exec = "wnpctl.sh get formatted";
          on-click-middle = "wnpctl.sh execute play_pause";
          on-click = "wnpctl.sh execute skip_previous";
          on-click-right = "wnpctl.sh execute skip_next";
          on-scroll-up = "wnpctl.sh execute volume_up";
          on-scroll-down = "wnpctl.sh execute volume_down";
        };
        memory = {
          format = "󰍛 {}%";
          format-alt = "󰍛 {used}/{total} GiB";
          interval = 5;
        };
        cpu = {
          format = "󰻠 {usage}%";
          format-alt = "󰻠 {avg_frequency} GHz";
          interval = 5;
        };
        "custom/vpn" = {
          exec = "mullvad status | awk '{print $1;}'";
          on-click = "mullvad connect";
          on-click-right = "mullvad disconnect";
          format = "󰱓󰅛 {}";
          interval = 5;
        };
        "custom/record" = {
          exec = "record.sh status";
          format = "{}";
          interval = 1;
        };
        tray = {
          icon-size = 16;
          spacing = 5;
        };
        "custom/brightness" = {
          interval = 1;
          exec = "brightness.sh get --json";
          return-type = "json";
          format = "{icon} {percentage}%";
          format-icons = ["" "" "" "" "" "" "" "" ""];
          on-scroll-up = "brightness.sh set +10";
          on-scroll-down = "brightness.sh set -10";
        };
        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = "󰝟";
          format-icons = {
            default = ["󰕿" "󰖀" "󰕾"];
          };
          on-click = "volume.sh toggle-mute";
          scroll-step = 5;
          on-click-right = "pavucontrol";
        };
      };
    };
    style = ''
      @define-color base   #1e1e2e;
      @define-color mantle #181825;
      @define-color crust  #11111b;

      @define-color text     #cdd6f4;
      @define-color subtext0 #a6adc8;
      @define-color subtext1 #bac2de;

      @define-color surface0 #313244;
      @define-color surface1 #45475a;
      @define-color surface2 #585b70;

      @define-color overlay0 #6c7086;
      @define-color overlay1 #7f849c;
      @define-color overlay2 #9399b2;

      @define-color blue      #89b4fa;
      @define-color lavender  #b4befe;
      @define-color sapphire  #74c7ec;
      @define-color sky       #89dceb;
      @define-color teal      #94e2d5;
      @define-color green     #a6e3a1;
      @define-color yellow    #f9e2af;
      @define-color peach     #fab387;
      @define-color maroon    #eba0ac;
      @define-color red       #f38ba8;
      @define-color mauve     #cba6f7;
      @define-color pink      #f5c2e7;
      @define-color flamingo  #f2cdcd;
      @define-color rosewater #f5e0dc;

      * {
        font-family: FantasqueSansMono Nerd Font;
        font-size: 17px;
        min-height: 0;
      }

      #waybar {
        background: transparent;
        color: @text;
        margin: 5px 5px;
      }

      #workspaces {
        border-radius: 1rem;
        margin: 5px;
        background-color: @surface0;
        margin-left: 1rem;
      }

      #workspaces button {
        color: @lavender;
        border-radius: 1rem;
        padding: 0.4rem;
      }

      #workspaces button.active {
        color: @sky;
        border-radius: 1rem;
      }

      #workspaces button:hover {
        color: @sapphire;
        border-radius: 1rem;
      }

      #custom-music,
      #tray,
      #backlight,
      #clock,
      #battery,
      #pulseaudio,
      #custom-lock,
      #custom-power {
        background-color: @surface0;
        padding: 0.5rem 1rem;
        margin: 5px 0;
      }

      #clock {
        color: @blue;
        border-radius: 0px 1rem 1rem 0px;
        margin-right: 1rem;
      }

      #battery {
        color: @green;
      }

      #battery.charging {
        color: @green;
      }

      #battery.warning:not(.charging) {
        color: @red;
      }

      #backlight {
        color: @yellow;
      }

      #backlight, #battery {
          border-radius: 0;
      }

      #pulseaudio {
        color: @maroon;
        border-radius: 1rem 0px 0px 1rem;
        margin-left: 1rem;
      }

      #custom-music {
        color: @mauve;
        border-radius: 1rem;
      }

      #custom-lock {
          border-radius: 1rem 0px 0px 1rem;
          color: @lavender;
      }

      #custom-power {
          margin-right: 1rem;
          border-radius: 0px 1rem 1rem 0px;
          color: @red;
      }

      #tray {
        margin-right: 1rem;
        border-radius: 1rem;
      }
    '';
  };
}
