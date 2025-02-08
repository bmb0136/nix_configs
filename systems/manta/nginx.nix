{...}: {
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
  };
}
