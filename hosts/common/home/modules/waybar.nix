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

{ host, ... }:

let 
  output = with host;
    if hostName == "desktop" then
      [ "DP-1" ]
    else if hostName == "laptop" then
      [ "eDP-1" ]
    else [ ];
  modules-right = with host;
    if hostName == "desktop" then
      [ "custom/record" "tray" "custom/mic" "pulseaudio" "custom/brightness" "clock" ]
    else if hostName == "laptop" then
      [ "custom/record" "tray" "custom/mic" "pulseaudio" "backlight" "battery" "clock" ]
    else [ ];
  smooth-scrolling-threshold = with host;
    if hostName == "laptop" then 5
    else 0;
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
        modules-left = ["hyprland/workspaces" "cpu" "memory" "custom/wnp" ];
        modules-center = [ ];
        modules-right = modules-right;
        "hyprland/workspaces" = {
          all-outputs = true;
          format = "{icon}";
          format-icons = {
            sort-by-number = true;
            default = "󰧞";
            active = "";
            urgent = "";
          };
          on-click = "activate";
        };
        cpu = {
          format = "󰻠  {usage}%";
          format-alt = "󰻠  {avg_frequency} GHz";
          interval = 5;
        };
        memory = {
          format = "󰍛  {}%";
          format-alt = "󰍛  {used}/{total} GiB";
          interval = 5;
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
        "custom/record" = {
          exec = "record.sh status";
          format = "{}";
          interval = 1;
        };
        tray = {
          icon-size = 16;
          spacing = 10;
          reverse-direction = true;
        };
        "custom/mic" = {
          exec = "audio.sh source get --waybar";
          return-type = "json";
          interval = 1;
          on-click = "audio.sh source toggle-mute";
          on-click-right = "pavucontrol";
        };
        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = "󰝟";
          format-icons = {
            default = ["󰕿 " "󰖀 " "󰕾 "];
          };
          scroll-step = 5;
          reverse-scrolling = true;
          smooth-scrolling-threshold = smooth-scrolling-threshold;
          on-click = "audio.sh sink toggle-mute";
          on-click-right = "pavucontrol";
        };
        backlight = {
          format = "{icon}  {percent}%";
          format-icons = ["" "" "" "" "" "" "" "" ""];
          scroll-step = 5;
          reverse-scrolling = true;
          smooth-scrolling-threshold = smooth-scrolling-threshold;
        };
        "custom/brightness" = {
          exec = "brightness.sh get --json";
          return-type = "json";
          format = "{icon}  {percentage}%";
          interval = 1;
          reverse-scrolling = true;
          smooth-scrolling-threshold = smooth-scrolling-threshold;
          format-icons = ["" "" "" "" "" "" "" "" ""];
          on-scroll-up = "brightness.sh set +10";
          on-scroll-down = "brightness.sh set -10";
        };
        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = "󱐋 {capacity}%";
          format-icons = ["  " "   " "  " "  " "  "];
          interval = 5;
        };
        clock = {
          format = "  {:%H:%M}";
          format-alt = "  {:%Y-%m-%d}";
        };
      };
    };
    style = ''
      @define-color base   #1e1e2e;
      @define-color mantle #181825;
      @define-color mantle_t rgba(24, 24, 37, 0.6);
      @define-color crust  #11111b;

      @define-color text     #cdd6f4;
      @define-color subtext0 #a6adc8;
      @define-color subtext1 #bac2de;

      @define-color surface0 #313244;
      @define-color surface0_t rgba(49, 50, 68, 0.6);
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
        background: @mantle_t;
        color: @text;
      }

      #workspaces {
        border-radius: 1rem;
        margin: 5px;
        background-color: @surface0_t;
        margin-left: 1rem;
      }

      #workspaces button {
        color: @lavender;
        border-radius: 1rem;
        padding-left: 0.7rem;
        padding-right: 0.7rem;
        transition: none;
      }

      #workspaces button.active {
        color: @mauve;
        border-radius: 1rem;
        padding-left: 0.4rem;
      }

      #workspaces button:hover {
        color: @sapphire;
        border-radius: 1rem;
      }

      #tray,
      #backlight,
      #custom-brightness,
      #clock,
      #battery,
      #pulseaudio,
      #custom-vpn,
      #custom-mic,
      #cpu,
      #memory {
        background-color: @surface0_t;
        padding: 0.5rem 0.7rem;
        margin: 5px 0;
      }

      #custom-wnp {
        /* color: @sky; */
        background-color: @surface0_t;
        margin: 5px 0;
        padding: 0.5rem 1rem;
        border-radius: 1rem 1rem;
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

      #backlight, #custom-brightness {
        color: @yellow;
      }

      #custom-record {
        margin-right: 0.5rem;
      }

      #cpu {
        border-radius: 1rem 0px 0px 1rem;
        padding-right: 0rem;
      }

      #memory {
        border-radius: 0px 1rem 1rem 0px;
        margin-right: 0.5rem;
      }

      #custom-mic {
        border-radius: 1rem;
        margin-left: 0.5rem;
        padding: 0 0.7rem 0 0.7rem;
        color: #DFDFDF;
      }

      #pulseaudio {
        color: @maroon;
        border-radius: 1rem 0px 0px 1rem;
        margin-left: 0.5rem;
      }

      #tray {
        border-radius: 1rem;
      }
    '';
  };
}