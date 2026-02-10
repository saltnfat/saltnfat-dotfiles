{
  pkgs,
  host,
  ...
}:
let
  inherit (import ../hosts/${host}/options.nix) stylixImage;
in
{
  # Styling Options
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    image = stylixImage;
    polarity = "dark";
    opacity.terminal = 1.0;
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };
    fonts = {
      monospace = {
        package = pkgs.maple-mono.NF;
        name = "Maple Mono NF";
      };
      # sansSerif = {
      #   package = pkgs.montserrat;
      #   name = "Montserrat";
      # };
      # serif = {
      #   package = pkgs.montserrat;
      #   name = "Montserrat";
      # };
      sizes = {
        applications = 12;
        terminal = 11.5;
        desktop = 11;
        popups = 12;
      };
    };
  };
}
