{ config, pkgs, ... };

{
  home.username = "andrew";
  home.homeDirectory = "/home/andrew/";
  home.stateVersion = "unstable";

  home.packages = with pkgs; [
    htop
    fastfetch
  ];

  
  programs.git = {
    enable = true;
    userName = "Andrew Palski";
    userEmail = "ampalski@gmail.com";
    extraConfig = {
      init.defaultbranch= "main";
    };
  };

  programs.home-manager.enable = true;
}
