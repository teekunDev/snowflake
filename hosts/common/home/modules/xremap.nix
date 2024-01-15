#
#  xremap nixOS configuration.
#
#  flake.nix
#   └─ ./hosts
#       └─ ./common
#           └─ ./configuration
#               ├─ configuration.nix !
#               └─ ./modules
#                   └─ xremap.nix *
#

{ inputs, vars, lib, pkgs, host, ... }:

# Using xremap in home-manager because the system one
# would not work with application specific settings

{
  imports = [
    inputs.xremap.homeManagerModules.default
  ];

  home.packages = with pkgs; [
    inputs.xremap.packages.${system}.default
  ];

  services.xremap = {
    withWlroots = true;
    watch = true;
    mouse = host.hostName == "desktop";
    debug = false;
    yamlConfig = ''
      modmap:
        - name: FFXIV
          application:
            only: ffxiv_dx11.exe
          remap:
            CapsLock: Alt_L
            Btn_Extra: Alt_R
      keymap:
        - name: FFXIV
          application:
            only: ffxiv_dx11.exe
          remap:
            Alt_R-Key_1: Key_7
            Alt_R-Key_2: Key_8
            Alt_R-Key_3: Key_9
            Alt_R-Key_4: Key_0
            Alt_R-Key_5: Key_Minus
            Alt_R-Key_6: Key_Equal
        - name: AltGr
          remap:
            Ctrl_L-ALT_L-Key_2: Alt_R-Key_2                    # ²
            Ctrl_L-ALT_L-Key_3: Alt_R-Key_3                    # ³
            Ctrl_L-ALT_L-Key_7: Alt_R-Key_7                    # {
            Ctrl_L-ALT_L-Key_8: Alt_R-Key_8                    # [
            Ctrl_L-ALT_L-Key_9: Alt_R-Key_9                    # ]
            Ctrl_L-ALT_L-Key_0: Alt_R-Key_0                    # }
            Ctrl_L-ALT_L-Key_Q: Alt_R-Key_Q                    # @
            Ctrl_L-ALT_L-Key_E: Alt_R-Key_E                    # €
            Ctrl_L-ALT_L-Key_Minus: Alt_R-Key_Minus            # \
            Ctrl_L-ALT_L-Key_RightBrace: Alt_R-Key_RightBrace  # ~
            Ctrl_L-ALT_L-Key_102ND: Alt_R-Key_102ND            # |
    '';
  };

  systemd.user.services.xremap.Unit.PartOf = lib.mkForce [ "graphical.target" ];
  systemd.user.services.xremap.Unit.After = lib.mkForce [ "graphical.target" ];
  systemd.user.services.xremap.Install.WantedBy = lib.mkForce [ "graphical.target" ];
}
