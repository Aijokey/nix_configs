# customisation.nix - UI customization (currently disabled)
# ============================================================================
{
  config,
  pkgs,
  lib,
  packages,
  ...
}: {
  /*
  environment.variables = {
    # Default (optional fallback)
    QT_ICON_THEME = "MoreWaita";
    XDG_CURRENT_DESKTOP = "GNOME";
    QT_QPA_PLATFORMTHEME="qt6ct";
  };
  */
  qt.style = "qt6ct";
  qt.platformTheme = "gnome";
}
