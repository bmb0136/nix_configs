{...}: {
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    virtualHosts."manta.zt" = {
      default = true;
      locations."/" = {
        alias = ./404.html;
      };
    };
  };
}
