{
  config,
  pkgs,
  ...
}: {
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;

    # Map an existing system user → MariaDB user

    settings = {
      mysqld = {
        bind-address = "127.0.0.1";
        port = 3306;
      };
    };
  };
}
