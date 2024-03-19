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

{ vars, ... }:

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
        action = "swaylock & systemctl hibernate";
        text = "Hibernate";
        keybind = "h";
      }
      {
        label = "logout";
        action = "touch ~/.no-hypr && loginctl terminate-user $USER";
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
        action = "swaylock & systemctl suspend";
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
        background-image: url("${vars.location}/files/images/wlogout/noise.png");
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
        background-image: url("${vars.location}/files/images/wlogout/lock.png");
      }

      #logout {
        margin: 10px;
        border-radius: 20px;
        background-image: url("${vars.location}/files/images/wlogout/logout.png");
      }

      #suspend {
        margin: 10px;
        border-radius: 20px;
        background-image: url("${vars.location}/files/images/wlogout/suspend.png");
      }

      #hibernate {
        margin: 10px;
        border-radius: 20px;
        background-image: url("${vars.location}/files/images/wlogout/hibernate.png");
      }

      #shutdown {
        margin: 10px;
        border-radius: 20px;
        background-image: url("${vars.location}/files/images/wlogout/shutdown.png");
      }

      #reboot {
        margin: 10px;
        border-radius: 20px;
        background-image: url("${vars.location}/files/images/wlogout/reboot.png");
      }
    '';
  };
}