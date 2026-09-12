_: {
  flake.nixosModules.desktop = _: {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = false;
    };

    home-manager.sharedModules = [
      {
        wayland.windowManager.sway.config.keybindings = let
          noctalia = "noctalia-shell ipc call";
        in {
          "XF86AudioRaiseVolume" = "exec ${noctalia} volume increase";
          "XF86AudioLowerVolume" = "exec ${noctalia} volume decrease";
          "XF86AudioMute" = "exec ${noctalia} volume muteOutput";
          "XF86AudioMicMute" = "exec ${noctalia} volume muteInput";
          "XF86MonBrightnessUp" = "exec ${noctalia} brightness increase";
          "XF86MonBrightnessDown" = "exec ${noctalia} brightness decrease";
        };

        programs.niri.settings.binds = let
          noctalia = ["noctalia" "msg"];
        in {
          "XF86AudioRaiseVolume".action.spawn = noctalia ++ ["volume-up"];
          "XF86AudioLowerVolume".action.spawn = noctalia ++ ["volume-down"];
          "XF86AudioMute".action.spawn = noctalia ++ ["volume-mute"];
          "XF86AudioMicMute".action.spawn = noctalia ++ ["mic-mute"];
          "XF86MonBrightnessUp".action.spawn = noctalia ++ ["brightness-up"];
          "XF86MonBrightnessDown".action.spawn = noctalia ++ ["brightness-down"];
        };

        programs.noctalia.settings = {
          #brightness = {
          #  brightnessStep = 5;
          #  enableDdcSupport = false;
          #  enforceMinimum = false;
          #};
          # audio = {
          #   spectrumFrameRate = 30;
          #   spectrumMirrored = true;
          #   visualizerType = "wave";
          #   volumeFeedback = false;
          #   volumeFeedbackSoundFile = "";
          #   volumeOverdrive = false;
          #   volumeStep = 5;
          # };
          # osd = {
          #   enabled = true;
          #   position = "top_center";
          #   # autoHideMs = 2000;
          #   background_opacity = 1;
          #   # enabledTypes = [0 1 2 3];
          #   monitors = ["eDP-1"];
          # };
        };
      }
    ];
  };
}
