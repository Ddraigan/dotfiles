{
  pkgs,
  lib,
  config,
  inputs,
  colours,
  ...
}: {
  imports = [
    inputs.zen-browser.homeModules.beta
    ./xdg.nix
  ];
  options.modules.desktop.zen.enable = lib.mkEnableOption "Enable Zen Browser";
  config = lib.mkIf config.modules.desktop.zen.enable {
    programs.zen-browser = {
      enable = true;
      nativeMessagingHosts = [pkgs.firefoxpwa];
      policies = {
        AutofillAddressEnabled = false;
        AutofillCreditCardEnabled = false;
        DisableAppUpdate = true;
        DisableFeedbackCommands = true;
        DisableFirefoxStudies = true;
        DisablePocket = true; # save webs for later reading
        DisableTelemetry = true;
        DontCheckDefaultBrowser = true;
        OfferToSaveLogins = false;
      };
      profiles.default = {
        # userChrome = ''
        #   @-moz-document url(chrome://browser/content/browser.xul), url(chrome://browser/content/browser.xhtml) {
        #       #appcontent {
        #         background: transparent !important;
        #         }
        #     }
        # '';
        userChrome = import ./userChrome.nix {inherit colours;};
        userContent = import ./userContent.nix {inherit colours;};
        settings = let
          font = config.global.home.fonts;
        in {
          "font.name.monospace.x-western" = font.mono.name;
          "font.name.sans-serif.x-western" = font.sans.name;
          "font.name.serif.x-western" = font.serif.name;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "browser.tabs.allow_transparent_browser" = true;
          "zen.widget.linux.transparency" = true;
          "devtools.debugger.remote-enabled" = true;
          "devtools.chrome.enable" = true;
        };

        spaces = {
          "First" = {
            id = "bf0810f0-8216-458e-946b-d8e401616107";
            theme.opacity = 0.0;
            position = 1000;
          };
          "Second" = {
            id = "c0b6972d-e68f-4fd8-a60f-f3c0df9e4ca8";
            theme.opacity = 0.0;
            position = 2000;
          };
        };
        search = {
          force = true;
          default = "google";
          engines = {
            "Nix Packages" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "channel";
                      value = "stable";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              definedAliases = ["@pkgs"];
            };
            "Nix Options" = {
              urls = [
                {
                  template = "https://search.nixos.org/options";
                  params = [
                    {
                      name = "channel";
                      value = "stable";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              definedAliases = ["@nop"];
            };
            "Home Manager Options" = {
              urls = [
                {
                  template = "https://home-manager-options.extranix.com/";
                  params = [
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                    # {
                    #   name = "release";
                    #   value = "master"; # unstable
                    # }
                  ];
                }
              ];
              definedAliases = ["@hop"];
            };
          };
        };
      };
    };
  };
}
