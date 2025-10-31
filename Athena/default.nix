{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  roles = {
    blue = import ./roles/blue.nix {inherit pkgs;};
    bugbounty = import ./roles/bugbounty.nix {inherit pkgs;};
    cracker = import ./roles/cracker.nix {inherit pkgs;};
    dos = import ./roles/dos.nix {inherit pkgs;};
    forensic = import ./roles/forensic.nix {inherit pkgs;};
    malware = import ./roles/malware.nix {inherit pkgs;};
    mobile = import ./roles/mobile.nix {inherit pkgs;};
    network = import ./roles/network.nix {inherit pkgs;};
    osint = import ./roles/osint.nix {inherit pkgs;};
    red = import ./roles/red.nix {inherit pkgs;};
    student = import ./roles/student.nix {inherit pkgs;};
    web = import ./roles/web.nix {inherit pkgs;};
  };
in {
  options.cyber = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable the cyber module to install cyber security tools based on role(s).";
    };

    # ← changed from `role` to `roles`
    roles = mkOption {
      type = types.listOf (types.enum [
        "blue"
        "bugbounty"
        "cracker"
        "dos"
        "forensic"
        "malware"
        "mobile"
        "network"
        "osint"
        "red"
        "student"
        "web"
      ]);
      default = ["student"];
      description = "List of cyber roles whose tools to install.";
      example = ["student" "network"];
    };
  };

  config = mkIf config.cyber.enable {
    # flatten the list of lists of packages into a single list
    environment.systemPackages = builtins.concatMap (
      roleName:
        builtins.getAttr roleName roles
    )
    config.cyber.roles;
  };
}
