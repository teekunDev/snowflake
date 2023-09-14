#
#  wlogout home-manager configuration.
#
#  flake.nix
#   └─ ./hosts
#       └─ ./common
#           └─ ./home
#               ├─ home.nix !
#               └─ ./modules
#                   └─ wlogout.nix *
#

{ location, ... }:

{
  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "lock";
        action = "swaylock";
        text = "Lock";
        keybind = "l";
      }
      {
        label = "hibernate";
        action = "systemctl hibernate";
        text = "Hibernate";
        keybind = "h";
      }
      {
        label = "logout";
        action = "loginctl terminate-user $USER";
        text = "Logout";
        keybind = "e";
      }
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Shutdown";
        keybind = "s";
      }
      {
        label = "suspend";
        action = "systemctl suspend";
        text = "Suspend";
        keybind = "u";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "Reboot";
        keybind = "r";
      }
    ];
    style = ''
      * {
        background-image: none;
        transition: 0ms;
      }

      window {
        background-color: rgba(17, 17, 27, 0.1);
        background-image: url('${location}/files/images/wlogout/noise.png');
      }

      button {
        color: #cdd6f4;
        border-style: solid;
        border-width: 2px;
        background-repeat: no-repeat;
        background-position: center;
        background-size: 25%;

        background-color: rgba(49, 50, 68, 0.4);
        border: 1px solid rgba(69, 71, 90, 0.3);
      }

      button:focus,
      button:active,
      button:hover {
        background-color: rgba(69, 71, 90, 0.5);
        border: 1px solid rgba(69, 71, 90, 0.15);
      }

      #lock {
        margin: 10px;
        border-radius: 20px;
        background-image: image(url("${location}/files/images/wlogout/lock.png"), url("/usr/local/share/wlogout/icons/lock.png"));
      }

      #logout {
        margin: 10px;
        border-radius: 20px;
        background-image: image(url("${location}/files/images/wlogout/logout.png"), url("/usr/local/share/wlogout/icons/logout.png"));
      }

      #suspend {
        margin: 10px;
        border-radius: 20px;
        background-image: image(url("${location}/files/images/wlogout/suspend.png"), url("/usr/local/share/wlogout/icons/suspend.png"));
      }

      #hibernate {
        margin: 10px;
        border-radius: 20px;
        background-image: image(url("${location}/files/images/wlogout/hibernate.png"), url("/usr/local/share/wlogout/icons/hibernate.png"));
      }

      #shutdown {
        margin: 10px;
        border-radius: 20px;
        background-image: image(url("${location}/files/images/wlogout/shutdown.png"), url("/usr/local/share/wlogout/icons/shutdown.png"));
      }

      #reboot {
        margin: 10px;
        border-radius: 20px;
        background-image: image(url("${location}/files/images/wlogout/reboot.png"), url("/usr/local/share/wlogout/icons/reboot.png"));
      }
    '';
  };
}