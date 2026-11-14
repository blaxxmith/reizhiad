_: {
  flake.homeModules.tools = {
    config,
    lib,
    ...
  }: let
    cfg = config.govelTY.tools.fastfetch;
    logo-blason = ''
      $1          ▗▄▄▄       $2▗▄▄▄▄    ▄▄▄▖
      $1          ▜███▙       $2▜███▙  ▟███▛
      $1           ▜███▙       $2▜███▙▟███▛
      $1            ▜███▙       $2▜██████▛
      $1     ▟█████████████████▙ $2▜████▛     $1▟▙
      $1    ▟███████████████████▙ $2▜███▙    $1▟██▙
      $2           ▄▄▄▄ $4▗▄▄▄▄▄▄▄▄▄▖$2▜███▙  $1▟███▛
      $2          ▟███▛ $4▐█████████▌ $2▜██▛ $1▟███▛
      $2         ▟███▛  $4▐█████████▌  $2▜▛ $1▟███▛
      $2▟███████████▛   $4▐█████████▌    $1▟██████████▙
      $2▜██████████▛    $4▐█████████▌   $1▟███████████▛
      $2      ▟███▛     $4▝▀▀▀▀▜▛▀▀▀▘   $1▝▀▀▀▀▘
      $3    ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▟██████████████████▛
      $3     ▜█████████████████████████████▛
      $3       ▜████████████████████████▛
      $3         ▀▀▀▀▀▀▀▀██████████▛
      $3                 ▐█████████
      $3                 ▟█████████▙
      $3                ▟███▛   ▜███▙
    '';
  in {
    options.govelTY.tools.fastfetch.enable = lib.mkEnableOption "Fastfetch";

    config = lib.mkIf cfg.enable {
      programs.fastfetch = {
        enable = true;
        settings = {
          logo = {
            type = "data";
            source = logo-blason;
            color = {
              "1" = "blue";
              "2" = "cyan";
              "3" = "white";
              "4" = "red";
            };
          };
          display = {
            separator = ":: ";
          };
          modules = [
            {type = "title";}
            "separator"
            {type = "host";}
            {type = "os";}
            {type = "packages";}
            {type = "cpu";}
            {type = "memory";}
            {type = "gpu";}
            {type = "swap";}
            {type = "kernel";}
            {type = "shell";}
            {type = "terminal";}
            {type = "uptime";}
            "break"
            {type = "colors";}
          ];
        };
      };
    };
  };
}
