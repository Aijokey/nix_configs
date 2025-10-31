{
  config,
  pkgs,
  ...
}: {
  users.users.aijokey = {
    isNormalUser = true;
    description = "Aijokey";
    extraGroups = ["networkmanager" "wheel" "gamemode"];
    packages = with pkgs; [
      #  thunderbird
    ];
  };
}
