_: {
  flake.nixosModules.desktop = {
    config,
    lib,
    pkgs,
    ...
  }: let
    cfg = config.forgeOS.desktop.bars;
    betterTransition = "all 0.3s cubic-bezier(.55,-0.68,.48,1.682)";
  in {
    options.forgeOS.desktop.bars.enable = lib.mkEnableOption "Sway Bars";

    config = lib.mkIf cfg.enable {
      home-manager.sharedModules = [
        {
          wayland.windowManager.sway.config.bars = [{command = "${pkgs.waybar}/bin/waybar";}];

          programs.waybar = {
            enable = true;
            settings = {
              mainbar = {
                layer = "top";
                height = 12;
                position = "top";
                margin-top = 0;

                modules-left = ["clock" "network" "sway/mode"];
                modules-center = ["sway/workspaces" "privacy"];
                modules-right = ["temperature" "cpu" "memory" "disk" "pulseaudio" "battery"];

                clock = {
                  interval = 5;
                  format = "{:%R:%S}";
                  format-alt = "{:%Y-%m-%d}";
                  tooltip-format = "{:%Y-%m-%d | %H:%M}";
                };
                temperature = {
                  interval = 5;
                  thermal-zone = 2;
                  format = "{temperatureC}°C ";
                  critical-threshold = 60;
                  format-critical = "  {temperatureC}°C ";
                };
                cpu = {
                  interval = 5;
                  format = "{usage}%  ";
                  states = {
                    critical = 90;
                    warning = 75;
                    normal = 50;
                  };
                  format-critical = "  {usage}%  ";
                  format-warning = "  {usage}%  ";
                };
                memory = {
                  format = "{percentage}%  ";
                  states = {
                    critical = 90;
                    warning = 75;
                  };
                  format-critical = "  {percentage}%  ";
                  format-warning = "  {percentage}%  ";
                };
                disk = {
                  interval = 5;
                  format = "{free} 󰋊";
                  path = "/";
                  units = "GB";
                  tooltip-format = "/: {percentage_used}% ({used})";
                };
                network = {
                  interval = 1;
                  format-alt = "  {bandwidthUpBits}   {bandwidthDownBits}";
                  format-disconnected = "  No Network";
                  format-linked = "  No IP";
                  format-ethernet = "E::{ipaddr}";
                  tooltip-format-ethernet = "{ifname}::{ipaddr}/{cidr}::{gwaddr}";
                  format-wifi = "W::{ipaddr}";
                  tooltip-format-wifi = "   {essid}::{frequency}GHz {signalStrength}%";
                };
                battery = {
                  interval = 1;
                  format = "{capacity}% {icon} ";
                  format-alt = "{power} {icon} ";
                  format-icons = {
                    critical = "";
                    warning = "";
                    normal = "";
                    full = "";
                  };
                  states = {
                    critical = 25;
                    warning = 35;
                    normal = 94;
                    full = 100;
                  };
                  format-critical = "  {capacity}% {icon} ";
                  format-warning = "  {capacity}% {icon} ";
                  format-full = "  {capacity}% {icon} ";
                  format-charging = "  {capacity}% {icon} ";
                };
                "sway/workspaces" = {
                  format = "{icon}";
                  format-icons = {
                    "1" = " ";
                    "2" = "󰖟";
                    "3" = " ";
                    "4" = "4";
                    "5" = "5";
                    "6" = "6";
                    "7" = "7";
                    "8" = "8";
                    "9" = " ";
                    "10" = " ";
                    default = "";
                    focused = "·";
                    urgent = " ";
                    empty = "";
                  };
                };
                "sway/mode".format = "mode::{}";
                pulseaudio = {
                  format = "{volume}% {icon}";
                  format-muted = "muted";
                  format-icons = {
                    "alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__Speaker__sink" = " ";
                    "alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__Headphones__sink" = " ";
                  };
                };
                privacy = {
                  modules = [{type = "screenshare";} {type = "audio-in";} {type = "audio-out";}];
                };
              };
            };

            style = ''
              * {
                font-size: 10px;
                border-radius: 0px;
                border: none;
                min-height: 0px;
              }
              window#waybar {
                background: rgba(0,0,0,0);
              }
              #workspaces {
              font-size: 10px;
                background-color: rgba(0, 0, 0, 0.5);
                margin: 3px 4px 0px 4px;
                padding: 5px 5px;
                border-radius: 16px;
              }
              #workspaces button {
                background-color: rgba(255, 255, 0, 0.1);
                padding: 0px 5px;
                margin: 0px 3px;
                border-radius: 16px;
                opacity: 0.5;
                transition: ${betterTransition};
              }
              #workspaces button.focused {
                font-weight: bold;
                background-color: rgba(255, 255, 255, 0.1);
                padding: 0px 5px;
                margin: 0px 3px;
                border-radius: 16px;
                transition: ${betterTransition};
                opacity: 1.0;
                min-width: 40px;
              }
              #workspaces button.urgent {
                background-color: rgba(255, 0, 0, 0.5);
                padding: 0px 5px;
                margin: 0px 3px;
                border-radius: 16px;
                opacity: 1.0;
                transition: ${betterTransition};
              }
              #workspaces button:hover {
                border-radius: 16px;
                opacity: 0.8;
                transition: ${betterTransition};
              }
              tooltip {
                border-radius: 16px;
                background-color: rgba(0, 0, 0, 0.9);
              }
              #window, #pulseaudio, #cpu, #memory, #idle_inhibitor,
              #battery, #tray, #custom-exit, #temperature, #disk, #pulseaudio {
                background-color: rgba(0, 0, 0, 0.5);
                margin: 3px 4px 0px 0px;
                padding: 0px 15px;
                border-radius: 16px;
              }
              #clock, #network, #mode, #privacy {
                background-color: rgba(0, 0, 0, 0.5);
                margin: 3px 0px 0px 4px;
                padding: 0px 15px;
                border-radius: 16px;
              }
              #battery.full, #battery.charging, #pulseaudio.muted, #privacy-item.audio-out {
                color: rgba(0, 255, 0, 0.5);
              }
              #battery.warning, #cpu.warning, #memory.warning, #privacy-item.audio-in {
                color: rgba(255, 255, 0, 0.5);
              }
              #battery.critical, #cpu.critical, #memory.critical, #temperature.critical, #privacy-item.screenshare {
                color: rgba(255, 0, 0, 0.5);
              }
            '';
          };
        }
      ];
    };
  };
}
