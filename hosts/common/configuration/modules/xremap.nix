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

{ inputs, vars, ... }:

{
  services.xremap = {
    withHypr = true;
    userName = "${vars.user}";
    yamlConfig = ''
      keymap:
        - name: Global
          remap:
            Ctrl_L-ALT_L-Key_2: Alt_R-KEY_2                    # ²
            Ctrl_L-ALT_L-Key_3: Alt_R-KEY_3                    # ³
            Ctrl_L-ALT_L-Key_7: Alt_R-KEY_7                    # {
            Ctrl_L-ALT_L-Key_8: Alt_R-KEY_8                    # [
            Ctrl_L-ALT_L-Key_9: Alt_R-KEY_9                    # ]
            Ctrl_L-ALT_L-Key_0: Alt_R-KEY_0                    # }
            Ctrl_L-ALT_L-Key_Q: Alt_R-Key_Q                    # @
            Ctrl_L-ALT_L-Key_E: Alt_R-Key_E                    # €
            Ctrl_L-ALT_L-Key_Minus: Alt_R-Key_Minus            # \
            Ctrl_L-ALT_L-Key_RightBrace: Alt_R-Key_RightBrace  # ~
            Ctrl_L-ALT_L-Key_102ND: Alt_R-Key_102ND            # |
    '';
  };
}
