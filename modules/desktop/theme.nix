_: {
  flake.nixosModules.desktop = {
    config,
    lib,
    ...
  }: let
    cfg = config.forgeOS.desktop.theme;
  in {
    options.forgeOS.desktop.theme = {
      enable = lib.mkEnableOption "Theme Configuration";
      wallpaper = lib.mkOption {
        type = lib.types.path;
        default = ../../.assets/wallpaper.png;
        description = "Path to the wallpaper image.";
      };
    };

    config.home-manager.sharedModules = lib.mkIf cfg.enable [
      {
        home.file = {
          ".config/gtk-4.0/settings.ini".text = ''
            [Settings]
            gtk-application-prefer-dark-theme=1
          '';
          ".config/gtk-3.0/settings.ini".text = ''
            [Settings]
            gtk-application-prefer-dark-theme=1
          '';

          ".assets/wallpaper.png".source = cfg.wallpaper;

          ".config/keymap.xkb".text = ''
            xkb_keymap {
                xkb_keycodes  { include "evdev+aliases(qwerty)" };
                xkb_types     { include "complete"               };
                xkb_compat    { include "complete"               };
                xkb_symbols   {
                    include "pc+us+inet(evdev)"

                    key <RALT>  { [ ISO_Level3_Shift ] };
                    modifier_map Mod5 { <RALT> };

                    key <CAPS>  { [ Escape ] };

                    key <AD03>  { [ e, E, dead_acute,      dead_acute      ] }; // Alt+e  → ´ (dead)
                    key <AC01>  { [ a, A, dead_grave,      dead_grave      ] }; // Alt+a  → ` (dead)
                    key <AD01>  { [ q, Q, U0153,           U0152           ] }; // Alt+q  → œ / Œ
                    key <AB03>  { [ c, C, ccedilla,        Ccedilla        ] }; // Alt+c  → ç / Ç
                    key <AD07>  { [ u, U, dead_diaeresis, dead_diaeresis ] }; // Alt+u  → ¨ (dead)
                    key <AD08>  { [ i, I, dead_circumflex,  dead_circumflex  ] }; // Alt+i  → ^ (dead)
                };
                xkb_geometry  { include "pc(pc105)" };
            };
          '';
        };

        programs.noctalia.settings = {
          # theme = {
          #   mPrimary = "#A7C080";
          #   mOnPrimary = "#232A2E";
          #   mSecondary = "#D3C6AA";
          #   mOnSecondary = "#232A2E";
          #   mTertiary = "#9DA9A0";
          #   mOnTertiary = "#232A2E";
          #   mError = "#E67E80";
          #   mOnError = "#232A2E";
          #   mSurface = "#232A2E";
          #   mOnSurface = "#859289";
          #   mSurfaceVariant = "#2D353B";
          #   mOnSurfaceVariant = "#D3C6AA";
          #   mOutline = "#7A8478";
          #   mShadow = "#475258";
          #   mHover = "#A7C080";
          #   mOnHover = "#232A2E";
          # };
          theme = {
            pure_black_dark = true;
            templates = {
              enable_builtin_templates = false;
              enable_community_templates = false;
            };
          };
        };
      }
    ];
  };
}
