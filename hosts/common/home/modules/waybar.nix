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
      [ "DP-1" "HDMI-A-1" ]
    else if hostName == "laptop" then
      [ "eDP-1" ]
    else [ ];
  fontsize1080p = "1.1rem";
  fontsize1440p = "1.3rem";
  horzmargin1080p = "1.2rem";
  horzmargin1440p = "1.5rem";
  vertmargin1080p = "0.2rem";
  vertmargin1440p = "0.5rem";
  sepmargin1080p = "0.8rem";
  sepmargin1440p = "1rem";
  customvpnleft1080p = "0.7rem";
  customvpnleft1440p = "0.9rem";
  stylevars = with host;
    if hostName == "desktop" then ''
    window.DP-1 * {
      font-size: ${fontsize1080p};
    }
    window.DP-1 #custom-nix {
      margin-left: ${horzmargin1080p};
    }
    window.DP-1 #workspaces {
      margin-top: ${vertmargin1080p};
      margin-bottom: ${vertmargin1080p};
    }
    window.DP-1 #custom-sep {
      padding-left: ${sepmargin1080p};
      padding-right: ${sepmargin1080p};
    }
    window.DP-1 #custom-vpn {
      margin-left: ${customvpnleft1080p};
      margin-right: ${customvpnleft1080p};
    }
    window.DP-1 #clock {
      margin-right: ${horzmargin1080p};
    }
    
    window.HDMI-A-1 * {
      font-size:  ${fontsize1080p};
    }
    window.HDMI-A-1 #custom-nix {
      margin-left: ${horzmargin1080p};
    }
    window.HDMI-A-1 #workspaces {
      margin-top: ${vertmargin1080p};
      margin-bottom: ${vertmargin1080p};
    }
    window.HDMI-A-1 #custom-sep {
      padding-left: ${sepmargin1080p};
      padding-right: ${sepmargin1080p};
    }
    window.HDMI-A-1 #custom-vpn {
      margin-left: ${customvpnleft1080p};
      margin-right: ${customvpnleft1080p};
    }
    window.HDMI-A-1 #clock {
      margin-right: ${horzmargin1080p};
    }
    '' else if hostName == "laptop" then ''
    window.eDP-1 * {
      font-size: ${fontsize1080p}
    }
    window.eDP-1 #custom-nix {
      margin-left: ${horzmargin1080p};
    }
    window.eDP-1 #workspaces {
      margin-top: ${vertmargin1080p};
      margin-bottom: ${vertmargin1080p};
    }
    window.eDP-1 #custom-sep {
      padding-left: ${sepmargin1080p};
      padding-right: ${sepmargin1080p};
    }
    window.eDP-1 #custom-vpn {
      margin-left: ${customvpnleft1080p};
      margin-right: ${customvpnleft1080p};
    }
    window.eDP-1 #clock {
      margin-right: ${horzmargin1080p};
    }
    '' else '''';
  modules-right = with host;
    if hostName == "desktop" then
      [ "custom/record" "tray" "custom/vpn" "custom/mic" "custom/sep" "pulseaudio" "custom/sep" "custom/brightness" "custom/sep" "clock" ]
    else if hostName == "laptop" then
      [ "custom/record" "tray" "custom/vpn" "custom/mic" "custom/sep" "pulseaudio" "custom/sep" "backlight" "custom/sep" "battery" "custom/sep" "clock" ]
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
        modules-left = [ "custom/nix" "custom/sep" "hyprland/workspaces" "custom/sep" "cpu" "memory" ];
        modules-center = [ "custom/wnp" ];
        modules-right = modules-right;
        "custom/nix" = {
          format = "";
          interval = "once";
          tooltip = false;
          on-click = "launcher.sh";
        };
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
        "custom/sep" = {
          format = "|";
          interval = "once";
          tooltip = false;
        };
        cpu = {
          format = "󰻠  {usage}%";
          format-alt = "󰻠  {avg_frequency} GHz";
          interval = 5;
        };
        memory = {
          format = " 󰍛  {}%";
          format-alt = "󰍛  {used}/{total} GiB";
          interval = 5;
        };
        "custom/wnp" = {
          format = "{}";
          return-type = "json";
          interval = 1;
          tooltip = true;
          exec = "wnpctl.sh get formatted --json";
          on-click-middle = "wnpctl.sh execute play_pause";
          on-click = "wnpctl.sh execute skip_previous";
          on-click-right = "wnpctl.sh execute skip_next";
          on-scroll-up = "wnpctl.sh execute volume_up";
          on-scroll-down = "wnpctl.sh execute volume_down";
        };
        # "custom/wnp" = {
        #   format = "{}";
        #   interval = 1;
        #   exec = "wnpcli metadata -f \"{{artist}} - {{title}}\"";
        #   on-click-middle = "wnpcli play-pause";
        #   on-click = "wnpcli skip-previous";
        #   on-click-right = "wnpcli skip-next";
        #   on-scroll-up = "wnpcli set-volume 2+";
        #   on-scroll-down = "wnpcli set-volume 2-";
        # };
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
        "custom/vpn" = {
          format = "{}";
          exec = "vpn.sh status --waybar";
          return-type = "json";
          interval = 1;
          on-click = "vpn.sh connect";
          on-click-right = "vpn.sh disconnect";
        };
        "custom/mic" = {
          format = "{}";
          exec = "audio.sh source get --waybar";
          return-type = "json";
          interval = 1;
          on-click = "audio.sh source toggle-mute";
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
          tooltip = true;
          tooltip-format = "<tt>{calendar}</tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            on-scroll-right = "mode";
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
          actions = {
            on-scroll-right = "mode";
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
          };
        };
      };
    };
    style = ''
      @define-color base   #1e1e2e;
      @define-color mantle #181825;
      @define-color mantle_t rgba(24, 24, 37, 0.3);
      @define-color crust  #11111b;

      @define-color text     #cdd6f4;
      @define-color subtext0 #a6adc8;
      @define-color subtext1 #bac2de;

      @define-color surface0 #313244;
      @define-color surface0_t rgba(49, 50, 68, 0.3);
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
        min-height: 0;
        border: unset;
      }

      ${stylevars}

      tooltip {
        background: @mantle;
        border-radius: 0.5rem;
      }

      tooltip label {
        color: @color;
      }

      #custom-sep {
        color: rgba(205, 214, 244, 0.1);
      }

      #waybar {
        background: @mantle_t;
      }

      #custom-nix {
        color: #7DAAD3;
        margin-right: 0.5rem;
      }

      #workspaces button {
        color: @lavender;
        padding-left: 0.4rem;
        padding-right: 0.4rem;
        transition: none;
      }

      #workspaces button.active {
        color: @mauve;
        padding-right: 0.6rem;
      }

      #workspaces button:hover {
        color: @sapphire;
      }

      #cpu,
      #memory,
      #custom-vpn,
      #custom-mic,
      #custom-wnp {
        color: @text;
      }

      #clock {
        color: @blue;
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

      #custom-mic {
        margin-right: 0.2rem;
      }

      #pulseaudio {
        color: @maroon;
      }
    '';
  };
}