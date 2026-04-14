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
          noctaliaShell = "noctalia-shell ipc call";
        in {
          "XF86AudioRaiseVolume" = "exec ${noctaliaShell} volume increase";
          "XF86AudioLowerVolume" = "exec ${noctaliaShell} volume decrease";
          "XF86AudioMute" = "exec ${noctaliaShell} volume muteOutput";
          "XF86AudioMicMute" = "exec ${noctaliaShell} volume muteInput";
          "XF86MonBrightnessUp" = "exec ${noctaliaShell} brightness increase";
          "XF86MonBrightnessDown" = "exec ${noctaliaShell} brightness decrease";
        };

        programs.noctalia-shell.settings = {
          brightness = {
            brightnessStep = 5;
            enableDdcSupport = false;
            enforceMinimum = false;
          };
          audio = {
            spectrumFrameRate = 30;
            spectrumMirrored = true;
            visualizerType = "wave";
            volumeFeedback = false;
            volumeFeedbackSoundFile = "";
            volumeOverdrive = false;
            volumeStep = 5;
          };
          osd = {
            enabled = true;
            location = "top";
            autoHideMs = 2000;
            backgroundOpacity = 1;
            enabledTypes = [0 1 2 3];
            monitors = ["eDP-1"];
          };
        };
      }
    ];
  };
}
