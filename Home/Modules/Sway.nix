{ config, pkgs, ... }:

{
  wayland.windowManager.sway = {
    enable = true;
    extraOptions = [ "--unsupported-gpu" ];
    checkConfig = false;
    wrapperFeatures.gtk = true;

    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
      export _JAVA_AWT_WM_NONREPARENTING=1
      export MOZ_ENABLE_WAYLAND=1
      export LIBVA_DRIVER_NAME=nvidia
      export GBM_BACKEND=nvidia-drm
      export __GLX_VENDOR_LIBRARY_NAME=nvidia
      export XCURSOR_SIZE=16
    '';


    extraConfig = ''
      input * {
          xkb_layout us
      }

      input "1133:16552:Logitech_PRO_2_MOUSE" {
    	pointer_accel -0.5
    	accel_profile flat
      }

      set $mod Mod4
      set $term foot 
      set $file nautilus --new-window
      set $menu wofi --show drun
      set $wallpaper ~/Pictures/Wallpapers/polina-kuzovkova.jpg

      output HDMI-A-1 resolution 1920x1080@144Hz position 0,0
      output HDMI-A-1 bg $wallpaper fill

      floating_modifier $mod normal

      bindsym $mod+t       exec $term
      bindsym $mod+o       exec $menu
      bindsym $mod+e       exec $file
      bindsym $mod+c       kill
      bindsym $mod+Shift+s exec slurp | grim -g - - | wl-copy

      bindsym $mod+f       fullscreen toggle
      bindsym $mod+s       floating toggle

      bindsym $mod+a reload
      bindsym $mod+Shift+e exec swaynag -t warning \
          -m 'Vuoi uscire da sway?' \
          -B 'Sì, esci' 'swaymsg exit'

      bindsym $mod+Left  focus left
      bindsym $mod+Down  focus down
      bindsym $mod+Up    focus up
      bindsym $mod+Right focus right

      bindsym $mod+h focus left
      bindsym $mod+j focus down
      bindsym $mod+k focus up
      bindsym $mod+l focus right

      bindsym $mod+Shift+Left  move left
      bindsym $mod+Shift+Down  move down
      bindsym $mod+Shift+Up    move up
      bindsym $mod+Shift+Right move right

      bindsym $mod+Shift+h move left
      bindsym $mod+Shift+j move down
      bindsym $mod+Shift+k move up
      bindsym $mod+Shift+l move right

      set $ws1  "1"
      set $ws2  "2"
      set $ws3  "3"
      set $ws4  "4"
      set $ws5  "5"
      set $ws6  "6"
      set $ws7  "7"
      set $ws8  "8"
      set $ws9  "9"
      set $ws10 "10"

      bindsym $mod+1  workspace number $ws1
      bindsym $mod+2  workspace number $ws2
      bindsym $mod+3  workspace number $ws3
      bindsym $mod+4  workspace number $ws4
      bindsym $mod+5  workspace number $ws5
      bindsym $mod+6  workspace number $ws6
      bindsym $mod+7  workspace number $ws7
      bindsym $mod+8  workspace number $ws8
      bindsym $mod+9  workspace number $ws9
      bindsym $mod+0  workspace number $ws10

      bindsym $mod+Shift+1  move container to workspace number $ws1
      bindsym $mod+Shift+2  move container to workspace number $ws2
      bindsym $mod+Shift+3  move container to workspace number $ws3
      bindsym $mod+Shift+4  move container to workspace number $ws4
      bindsym $mod+Shift+5  move container to workspace number $ws5
      bindsym $mod+Shift+6  move container to workspace number $ws6
      bindsym $mod+Shift+7  move container to workspace number $ws7
      bindsym $mod+Shift+8  move container to workspace number $ws8
      bindsym $mod+Shift+9  move container to workspace number $ws9
      bindsym $mod+Shift+0  move container to workspace number $ws10

      gaps inner 5
      gaps outer 10
      default_border pixel 2

      client.focused          #88c0d0 #88c0d0 #2e3440 #81a1c1 #88c0d0
      client.unfocused        #3b4252 #2e3440 #d8dee9 #3b4252 #3b4252
      client.focused_inactive #434c5e #3b4252 #d8dee9 #434c5e #434c5e
      client.urgent           #bf616a #bf616a #eceff4 #bf616a #bf616a

      exec systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
      exec systemctl --user start pipewire pipewire-pulse wireplumber
      exec dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    '';
  };
}
