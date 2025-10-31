# system/locale.nix - Locale and timezone configuration
# ============================================================================
{
  config,
  pkgs,
  ...
}: {
  time.timeZone = "Europe/Kyiv";
  i18n.defaultLocale = "en_GB.UTF-8";
}
# ============================================================================

