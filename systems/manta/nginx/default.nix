{...}: {
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    virtualHosts."manta.zt" = {
      default = true;
      locations."/" = {
        tryFiles = "${./404.html} =404";
      };
    };
  };
}
