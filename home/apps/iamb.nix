{
  config,
  lib,
  ...
}: let
  cfg = config.forgeOS.apps.iamb;
in {
  options.forgeOS.apps.iamb.enable = lib.mkEnableOption "IAMB Matrix Client";

  config = lib.mkIf cfg.enable {
    programs.iamb = {
      enable = true;
      settings = {
        default_profile = "pki";
        profiles = {
          pki = {
            user_id = "@x:p.ki";
            url = "https://chat.p.ki";
          };
        };
        layout = {
          style = "restore";
        };
        settings = {
          message_shortcode_display = true;
          reaction_shortcode_display = true;
          image_preview.protocol = {
            type = "halfblocks";
          };
          notifications = {
            enabled = true;
            via = "bell";
          };
          users = {
            "@myn:p.ki".color = "yellow";
            "@x:p.ki".color = "green";
            "@avalanche:p.ki".color = "red";
          };
        };
      };
    };
  };
}
