{
  config,
  pkgs,
  lib,
  packages,
  ...
}: {
  environment.systemPackages = with pkgs; [
    libsForQt5.qt5ct
    qt6ct
    libsForQt5.qtstyleplugins
  ];

  # Set environment variables
  environment.variables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_STYLE_OVERRIDE = "gtk2";
  };
}
