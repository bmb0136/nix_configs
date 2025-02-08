{...}: {
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    virtualHosts."manta.zt" = {
      default = true;
      locations."/" = {
        return = ''404 "<p>Not Found :(</p>"'';
        extraConfig = ''add_header Content-Type text/html;'';
      };
    };
  };
}
