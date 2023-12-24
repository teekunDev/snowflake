#
#  Hyprland home-manager configuration.
#
#  flake.nix
#   └─ ./hosts
#       └─ ./common
#           └─ ./home
#               ├─ home.nix !
#               └─ ./modules
#                   └─ hyprland.nix *
#

{ config, lib, pkgs, host, vars, ... }:

let
  monitor-size = with host;
    if hostName == "desktop" then "6400 1440"
    else if hostName == "laptop" then "1920 1080"
    else "";
  leftmost-monitor = with host;
    if hostName == "desktop" then "HDMI-A-1"
    else if hostName == "laptop" then "eDP-1"
    else "";
  touchpad = with host;
    if hostName == "laptop" then ''
      touchpad {
        natural_scroll = true
        middle_button_emulation = true
        tap-to-click = true
      }
    '' else "";
  gestures = with host;
    if hostName == "laptop" then ''
      gestures {
        workspace_swipe = true
      }
    '' else "";
  monitors = with host;
    if hostName == "desktop" then ''
      monitor = HDMI-A-1, 1920x1080@144, 0x0, 1
      monitor = DP-1, 2560x1440@165, 1920x0, 1
      monitor = DP-2, 1920x1080@60, 4480x0, 1
    '' else if hostName == "laptop" then ''
      monitor = eDP-1, 1920x1080@144, 0x0, 1
    '' else "";
  workspaces = with host;
    if hostName == "desktop" then ''
      workspace = 1, monitor:DP-1, default:true
      workspace = 2, monitor:DP-1, default:false
      workspace = 3, monitor:DP-1, default:false
      workspace = 4, monitor:HDMI-A-1, default:true
      workspace = 5, monitor:HDMI-A-1, default:false
      workspace = 6, monitor:HDMI-A-1, default:false
      workspace = 7, monitor:DP-2, default:true
      workspace = 8, monitor:DP-2, default:false
      workspace = 9, monitor:DP-2, default:false

      windowrulev2 = workspace 4,class:^(firefox)$
    '' else if hostName == "laptop" then ''
      workspace = 1, monitor:eDP-1, default:true
      workspace = 2, monitor:eDP-1, default:false
      workspace = 3, monitor:eDP-1, default:falsed
    '' else "";
  execonce = with host;
    if hostName == "desktop" then ''
    '' else if hostName == "laptop" then ''
      exec-once = nm-applet
    '' else "";
in
let
  hyprlandConf = with host; ''
    ${monitors}
    monitor = , highres, auto, auto

    ${workspaces}

    input {
      kb_layout = de
      kb_variant = nodeadkeys
      kb_model = pc105
      kb_options = 
      kb_rules = 
      sensitivity = 0.5
      accel_profile = flat
      follow_mouse = 1
      ${touchpad}
    }

    ${gestures}

    general {
      gaps_in = 5
      gaps_out = 10
      border_size = 3
      col.active_border = rgba(c6a0f6ff)
      col.inactive_border = rgba(595959aa)
      no_cursor_warps = true
      layout = dwindle
    }

    misc {
      disable_hyprland_logo = true
      disable_splash_rendering = true
      enable_swallow = true
      swallow_regex = ^(kitty)$
    }

    decoration {
      rounding = 8

      active_opacity = 1
      inactive_opacity = 0.9
      
      blur {
        enabled = true
        size = 6
        passes = 3
        new_optimizations = true
        xray = true
        ignore_opacity = true
      }

      drop_shadow = false
      shadow_ignore_window = true
      shadow_offset = 1 2
      shadow_range = 10
      shadow_render_power = 5
      col.shadow = 0x66404040

      blurls = waybar
      blurls = lockscreen
    }

    animations {
      enabled = yes

      bezier = wind, 0.05, 0.9, 0.1, 1.05
      bezier = winIn, 0.1, 1.1, 0.1, 1.1
      bezier = winOut, 0.3, -0.3, 0, 1.
      bezier = linear, 1, 1, 1, 1

      animation = windows, 1, 6, wind, slide
      animation = windowsIn, 1, 6, winIn, slide
      animation = windowsOut, 1, 5, winOut, slide
      animation = windowsMove, 1, 5, wind, slide
      animation = border, 1, 1, linear
      animation = borderangle, 1, 30, linear, loop
      animation = fade, 1, 10, default
      animation = workspaces, 1, 3, wind, slidefadevert
    }

    dwindle {
      no_gaps_when_only = false
      pseudotile = true
      preserve_split = true
    }

    master {
      new_is_master = true
    }

    ### VARIABLES ###

    $scriptsDir = ${vars.location}/files/scripts

    $term = kitty
    $wall = $scriptsDir/wall.sh
    $wnp = $scriptsDir/wnpctl.sh
    $audio = $scriptsDir/audio.sh
    $alttab = $scriptsDir/alttab.sh
    $record = $scriptsDir/record.sh
    $launcher = $scriptsDir/launcher.sh
    $screenshot = $scriptsDir/screenshot.sh
    $brightness = $scriptsDir/brightness.sh
    $colorpicker = $scriptsDir/colorpicker.sh
    $randomchars = $scriptsDir/randomchars.sh
    $files = thunar
    $browser = firefox

    ### STARTUP ###

    exec-once = swaylock
    exec-once = exec-once=dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    exec-once = ssh-add ${vars.secrets}/git-ssh-key
    exec-once = gpg --import ${vars.secrets}/git-gpg-key
    exec-once = /usr/lib/polkit-kde-authentication-agent-1
    exec-once = hyprpaper
    exec-once = firefox
    exec-once = waybar
    exec-once = mako
    exec-once = wl-paste --type text --watch cliphist store
    exec-once = wl-paste --type image --watch cliphist store
    exec-once = startwnp.sh
    exec-once = xwaylandvideobridge
    exec-once $brightness scan
    ${execonce}

    ### ENV ###
    env=XCURSOR_SIZE,24

    ### KEYBINDS ###

    # submap
    submap = reset

    # Networking
    bind = SUPER_SHIFT, Prior, exec, nmcli networking on
    bind = SUPER_SHIFT, Next, exec, nmcli networking off

    # gtav CHEATS omg hacker hack3r holy shite
    bind = , F12, exec, /stuff/code/gtav-fingerprint-solver/run.sh

    # Audio Control
    bind = , XF86AudioPlay, exec, $wnp execute play_pause
    bind = , XF86AudioPrev, exec, $wnp execute skip_previous
    bind = , XF86AudioNext, exec, $wnp execute skip_next
    # bind = , XF86AudioRaiseVolume, exec, $audio sink set +5
    # bind = , XF86AudioLowerVolume, exec, $audio sink set -5
    bind = , XF86AudioRaiseVolume, exec, $wnp execute volume_up
    bind = , XF86AudioLowerVolume, exec, $wnp execute volume_down
    bind = , XF86AudioMute, exec, $audio sink toggle-mute
    bind = SUPER, M, exec, $audio source toggle-mute --ping

    # Alt Tab
    bind = ALT, TAB, exec, $alttab

    # Screenshot & Recording
    bind = , Print, exec, $screenshot
    bind = CTRL, Print, exec, $record
    bind = CTRL_SHIFT, Print, exec, $record --audio

    # Brightness
    bind = SUPER, Prior, exec, $brightness set 100
    bind = SUPER, Next, exec, $brightness set 0

    # Misc
    bind = SUPER, W, exec, $wall
    bind = CTRL_SHIFT, R, exec, $randomchars
    bind = CTRL_SHIFT, SPACE, exec, $launcher
    bind = CTRL_SHIFT, Escape, exec, $term --hold btop
    bind = SUPER, P, exec, $colorpicker
    bind = CTRL_ALT, L, exec, swaylock
    bind = SUPER, X, exec, $term
    bind = SUPER, E, exec, $files
    bind = SUPER, H, exec, cliphist list | wofi --dmenu --normal-window | cliphist decode | wl-copy
    bind = SUPER, L, exec, swaylock
    bind = SUPER, Q, exec, wlogout

    # Window Manager
    bind = SUPER, C, killactive,
    bind = SUPER_SHIFT, Q, exit,
    bind = SUPER, F, fullscreen,
    bind = SUPER, V, togglefloating,
    bind = SUPER, P, pseudo, # dwindle
    bind = SUPER, S, togglesplit, # dwindle
    bind = SUPER, Tab, cyclenext,
    bind = SUPER, Tab, bringactivetotop,

    # Focus
    bind = SUPER, left, movefocus, l
    bind = SUPER, right, movefocus, r
    bind = SUPER, up, movefocus, u
    bind = SUPER, down, movefocus, d

    # Move
    bind = SUPER_SHIFT, left, movewindow, l
    bind = SUPER_SHIFT, right, movewindow, r
    bind = SUPER_SHIFT, up, movewindow, u
    bind = SUPER_SHIFT, down, movewindow, d

    # Resize
    bind = SUPER_CTRL, left, resizeactive, -20 0
    bind = SUPER_CTRL, right, resizeactive, 20 0
    bind = SUPER_CTRL, up, resizeactive, 0 -20
    bind = SUPER_CTRL, down, resizeactive, 0 20

    # Switch
    bind = SUPER, 1, workspace, 1
    bind = SUPER, 2, workspace, 2
    bind = SUPER, 3, workspace, 3
    bind = SUPER, 4, workspace, 4
    bind = SUPER, 5, workspace, 5
    bind = SUPER, 6, workspace, 6
    bind = SUPER, 7, workspace, 7
    bind = SUPER, 8, workspace, 8
    bind = SUPER, 9, workspace, 9
    bind = SUPER, 0, workspace, 10

    # Move
    bind = SUPER SHIFT, 1, movetoworkspace, 1
    bind = SUPER SHIFT, 2, movetoworkspace, 2
    bind = SUPER SHIFT, 3, movetoworkspace, 3
    bind = SUPER SHIFT, 4, movetoworkspace, 4
    bind = SUPER SHIFT, 5, movetoworkspace, 5
    bind = SUPER SHIFT, 6, movetoworkspace, 6
    bind = SUPER SHIFT, 7, movetoworkspace, 7
    bind = SUPER SHIFT, 8, movetoworkspace, 8
    bind = SUPER SHIFT, 9, movetoworkspace, 9
    bind = SUPER SHIFT, 0, movetoworkspace, 10

    # Mouse
    bindm = SUPER, mouse:272, movewindow
    bindm = SUPER, mouse:273, resizewindow

    # reset submap
    submap = none
    bind = SUPER, escape, submap, reset

    ### WINDOW RULES ###

    # Opacity
    windowrulev2 = opacity 0.9 0.9,class:^(firefox)$
    windowrulev2 = opacity 0.9 0.9,class:^(.*code.*)$
    windowrulev2 = opacity 0.8 0.8,class:^(kitty)$
    windowrulev2 = opacity 0.8 0.8,class:^(Steam)$
    windowrulev2 = opacity 0.8 0.8,class:^(steam)$
    windowrulev2 = opacity 0.8 0.8,class:^(steamwebhelper)$
    windowrulev2 = opacity 0.8 0.8,class:^(thunar)$
    windowrulev2 = opacity 0.8 0.7,class:^(pavucontrol)$
    windowrulev2 = opacity 0.8 0.7,class:^(org.kde.polkit-kde-authentication-agent-1)$

    # Float
    windowrulev2 = float,class:^(org.kde.polkit-kde-authentication-agent-1)$
    windowrulev2 = float,class:^(pavucontrol)$
    windowrulev2 = float,class:^(swappy)$
    windowrulev2 = float,title:^(Media viewer)$
    windowrulev2 = float,title:^(Volume Control)$
    windowrulev2 = dimaround,title:^(Volume Control)$
    windowrulev2 = float,title:^(Picture-in-Picture)$
    windowrulev2 = float,title:^(DevTools)$
    windowrulev2 = float,class:^(file_progress)$
    windowrulev2 = float,class:^(confirm)$
    windowrulev2 = float,class:^(dialog)$
    windowrulev2 = float,class:^(download)$
    windowrulev2 = float,class:^(notification)$
    windowrulev2 = float,class:^(error)$
    windowrulev2 = float,class:^(confirmreset)$
    windowrulev2 = float,title:^(Open File)$
    windowrulev2 = float,title:^(branchdialog)$
    windowrulev2 = float,title:^(Confirm to replace files)$
    windowrulev2 = float,title:^(File Operation Progress)$

    # Fuck "Sharing Indicator" window
    windowrulev2 = float,title:^(.*Sharing Indicator.*)$
    windowrulev2 = nomaximizerequest,title:^(.*Sharing Indicator.*)$
    windowrulev2 = opacity 0,title:^(.*Sharing Indicator.*)$
    windowrulev2 = noblur,title:^(.*Sharing Indicator.*)$
    windowrulev2 = nofocus,title:^(.*Sharing Indicator.*)$
    windowrulev2 = noanim,title:^(.*Sharing Indicator.*)$
    windowrulev2 = noinitialfocus,title:^(.*Sharing Indicator.*)$

    # Screenshot Overlay
    windowrulev2 = monitor ${leftmost-monitor},class:^(screenshot-overlay)$
    windowrulev2 = float,class:^(screenshot-overlay)$
    windowrulev2 = noanim,class:^(screenshot-overlay)$
    windowrulev2 = move 0 0, class:^(screenshot-overlay)$
    windowrulev2 = size ${monitor-size},class:^(screenshot-overlay)$
    
    windowrulev2 = stayfocused,class:^(swappy)$
    windowrulev2 = float,class:^(swappy)$
    windowrulev2 = center,class:^(swappy)$

    # Wofi
    windowrulev2 = stayfocused,class:^(wofi)$
    windowrulev2 = size 40%,class:^(wofi)$
    windowrulev2 = float,class:^(wofi)$
    windowrulev2 = center,class:^(wofi)$

    # windowrulev2 = move 50% 44%title:^(Volume Control)$

    # Workspace
    # windowrulev2 = workspace, 2, class:^(firefox)$

    # Size
    windowrulev2 = size 800 600,class:^(download)$
    windowrulev2 = size 800 600,class:^(Open File)$
    windowrulev2 = size 800 600,class:^(Save File)$
    windowrulev2 = size 800 600,class:^(Volume Control)$

    windowrulev2 = idleinhibit focus,class:^(mpv)$
    windowrulev2 = idleinhibit fullscreen,class:^(firefox)$
    windowrulev2 = idleinhibit fullscreen,class:^(.*Minecraft.*)$

    # xwaylandvideobridge
    windowrulev2 = float,class:^(xwaylandvideobridge)$
    windowrulev2 = nomaximizerequest,class:^(xwaylandvideobridge)$
    windowrulev2 = opacity 0,class:^(xwaylandvideobridge)$
    windowrulev2 = noblur,class:^(xwaylandvideobridge)$
    windowrulev2 = nofocus,class:^(xwaylandvideobridge)$
    windowrulev2 = noanim,class:^(xwaylandvideobridge)$
    windowrulev2 = noinitialfocus,class:^(xwaylandvideobridge)$

    layerrule = noanim, ^(gtk-layer-shell)$

    windowrulev2 = float,class:^(wlogout)$
    windowrulev2 = move 0 0,class:^(wlogout)$
    windowrulev2 = size 100%,class:^(wlogout)$
    windowrulev2 = animation slide,class:^(wlogout)$

    # explorer.exe (wine)
    windowrulev2 = float,class:^(.*explorer.exe.*)$
    windowrulev2 = nomaximizerequest,class:^(.*explorer.exe.*)$
    windowrulev2 = opacity 0,class:^(.*explorer.exe.*)$
    windowrulev2 = noblur,class:^(.*explorer.exe.*)$
    windowrulev2 = nofocus,class:^(.*explorer.exe.*)$
  '';
in
{
  home.file.".config/hypr/hyprland.conf".text = hyprlandConf;
  home.file.".config/hypr/hyprpaper.conf".text = ''
    preload=${vars.location}/files/wall.png
    wallpaper=,${vars.location}/files/wall.png
  '';
}
