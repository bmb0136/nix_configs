{
  config,
  lib,
  ...
}: {
  services.gitea = {
    enable = true;
    settings = lib.mkIf config.services.nginx.enable {
      server.ROOT_URL = "http://git.manta.zt/";
    };
  };
  services.nginx.virtualHosts = lib.mkIf config.services.nginx.enable {
    virtualHosts."git.manta.zt" = {
      locations."/" = {
        proxyWebsockets = true;
        proxyPass = "http://127.0.0.1:3000";
        extraConfig = "client_max_body_size 512M;";
      };
    };
  };
}
