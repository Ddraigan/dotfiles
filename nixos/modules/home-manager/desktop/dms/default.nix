{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.dankMaterialShell.homeModules.dankMaterialShell.default
  ];
  options.modules.desktop.dms = {
    enable = lib.mkEnableOption "Enable Dank Material Shell";
  };
  config = lib.mkIf config.modules.desktop.dms.enable {
    programs.dankMaterialShell = {
      enable = true;
      # quickshell.package = pkgs.quickshell;
      systemd = {
        enable = false; # Systemd service for auto-start
        restartIfChanged = true; # Auto-restart dms.service when dankMaterialShell changes
      };
      # Core features
      enableSystemMonitoring = true; # System monitoring widgets (dgop)
      enableClipboard = false; # Clipboard history manager
      enableVPN = true; # VPN management widget
      # enableBrightnessControl = false; # Backlight/brightness controls
      # enableColorPicker = false; # Color picker tool
      enableDynamicTheming = false; # Wallpaper-based theming (matugen)
      enableAudioWavelength = true; # Audio visualizer (cava)
      enableCalendarEvents = true; # Calendar integration (khal)
      enableSystemSound = true; # System sound effects

      default.settings = {
        "currentThemeName" = "cat-pink";
        "customThemeFile" = "";
        "matugenScheme" = "scheme-tonal-spot";
        "runUserMatugenTemplates" = true;
        "matugenTargetMonitor" = "";
        "popupTransparency" = 1;
        "dockTransparency" = 1;
        "widgetBackgroundColor" = "s";
        "widgetColorMode" = "default";
        "cornerRadius" = 12;
        "use24HourClock" = true;
        "showSeconds" = false;
        "useFahrenheit" = false;
        "nightModeEnabled" = false;
        "animationSpeed" = 1;
        "customAnimationDuration" = 500;
        "wallpaperFillMode" = "Fill";
        "blurredWallpaperLayer" = false;
        "blurWallpaperOnOverview" = false;
        "showLauncherButton" = true;
        "showWorkspaceSwitcher" = true;
        "showFocusedWindow" = true;
        "showWeather" = true;
        "showMusic" = true;
        "showClipboard" = true;
        "showCpuUsage" = true;
        "showMemUsage" = true;
        "showCpuTemp" = true;
        "showGpuTemp" = true;
        "selectedGpuIndex" = 0;
        "enabledGpuPciIds" = [];
        "showSystemTray" = true;
        "showClock" = true;
        "showNotificationButton" = true;
        "showBattery" = true;
        "showControlCenterButton" = true;
        "showCapsLockIndicator" = true;
        "controlCenterShowNetworkIcon" = true;
        "controlCenterShowBluetoothIcon" = true;
        "controlCenterShowAudioIcon" = true;
        "controlCenterShowVpnIcon" = true;
        "controlCenterShowBrightnessIcon" = false;
        "controlCenterShowMicIcon" = false;
        "controlCenterShowBatteryIcon" = false;
        "controlCenterShowPrinterIcon" = false;
        "showPrivacyButton" = true;
        "privacyShowMicIcon" = false;
        "privacyShowCameraIcon" = false;
        "privacyShowScreenShareIcon" = false;
        "controlCenterWidgets" = [
          {
            "id" = "volumeSlider";
            "enabled" = true;
            "width" = 50;
          }
          {
            "id" = "brightnessSlider";
            "enabled" = true;
            "width" = 50;
          }
          {
            "id" = "wifi";
            "enabled" = true;
            "width" = 50;
          }
          {
            "id" = "bluetooth";
            "enabled" = true;
            "width" = 50;
          }
          {
            "id" = "audioOutput";
            "enabled" = true;
            "width" = 50;
          }
          {
            "id" = "audioInput";
            "enabled" = true;
            "width" = 50;
          }
          {
            "id" = "nightMode";
            "enabled" = true;
            "width" = 50;
          }
          {
            "id" = "darkMode";
            "enabled" = true;
            "width" = 50;
          }
        ];
        "showWorkspaceIndex" = true;
        "showWorkspacePadding" = false;
        "workspaceScrolling" = false;
        "showWorkspaceApps" = false;
        "maxWorkspaceIcons" = 3;
        "workspacesPerMonitor" = true;
        "showOccupiedWorkspacesOnly" = false;
        "dwlShowAllTags" = false;
        "workspaceNameIcons" = {};
        "waveProgressEnabled" = true;
        "scrollTitleEnabled" = true;
        "clockCompactMode" = false;
        "focusedWindowCompactMode" = false;
        "runningAppsCompactMode" = true;
        "keyboardLayoutNameCompactMode" = false;
        "runningAppsCurrentWorkspace" = false;
        "runningAppsGroupByApp" = false;
        "centeringMode" = "index";
        "clockDateFormat" = "";
        "lockDateFormat" = "";
        "mediaSize" = 1;
        "appLauncherViewMode" = "list";
        "spotlightModalViewMode" = "list";
        "sortAppsAlphabetically" = false;
        "appLauncherGridColumns" = 4;
        "spotlightCloseNiriOverview" = true;
        "niriOverviewOverlayEnabled" = true;
        "weatherLocation" = "Mynydd Isa= CH7 6UE";
        "weatherCoordinates" = "53.1677268=-3.1121717";
        "useAutoLocation" = false;
        "weatherEnabled" = true;
        "networkPreference" = "auto";
        "vpnLastConnected" = "";
        "iconTheme" = "System Default";
        "launcherLogoMode" = "apps";
        "launcherLogoCustomPath" = "";
        "launcherLogoColorOverride" = "";
        "launcherLogoColorInvertOnMode" = false;
        "launcherLogoBrightness" = 0.5;
        "launcherLogoContrast" = 1;
        "launcherLogoSizeOffset" = 0;
        "fontFamily" = "DejaVu Sans";
        "monoFontFamily" = "Hack Nerd Font Mono";
        "fontWeight" = 600;
        "fontScale" = 1.1;
        "notepadUseMonospace" = true;
        "notepadFontFamily" = "";
        "notepadFontSize" = 14;
        "notepadShowLineNumbers" = false;
        "notepadTransparencyOverride" = -1;
        "notepadLastCustomTransparency" = 0.7;
        "soundsEnabled" = true;
        "useSystemSoundTheme" = false;
        "soundNewNotification" = true;
        "soundVolumeChanged" = true;
        "soundPluggedIn" = true;
        "acMonitorTimeout" = 0;
        "acLockTimeout" = 0;
        "acSuspendTimeout" = 0;
        "acSuspendBehavior" = 0;
        "acProfileName" = "";
        "batteryMonitorTimeout" = 0;
        "batteryLockTimeout" = 0;
        "batterySuspendTimeout" = 0;
        "batterySuspendBehavior" = 0;
        "batteryProfileName" = "";
        "lockBeforeSuspend" = false;
        "loginctlLockIntegration" = true;
        "fadeToLockEnabled" = false;
        "fadeToLockGracePeriod" = 5;
        "launchPrefix" = "";
        "brightnessDevicePins" = {};
        "wifiNetworkPins" = {};
        "bluetoothDevicePins" = {};
        "audioInputDevicePins" = {};
        "audioOutputDevicePins" = {};
        "gtkThemingEnabled" = false;
        "qtThemingEnabled" = false;
        "syncModeWithPortal" = true;
        "terminalsAlwaysDark" = false;
        "showDock" = false;
        "dockAutoHide" = false;
        "dockGroupByApp" = false;
        "dockOpenOnOverview" = false;
        "dockPosition" = 1;
        "dockSpacing" = 4;
        "dockBottomGap" = 0;
        "dockMargin" = 0;
        "dockIconSize" = 40;
        "dockIndicatorStyle" = "circle";
        "dockBorderEnabled" = false;
        "dockBorderColor" = "surfaceText";
        "dockBorderOpacity" = 1;
        "dockBorderThickness" = 1;
        "notificationOverlayEnabled" = false;
        "modalDarkenBackground" = true;
        "lockScreenShowPowerActions" = true;
        "enableFprint" = false;
        "maxFprintTries" = 15;
        "lockScreenActiveMonitor" = "all";
        "lockScreenInactiveColor" = "#000000";
        "hideBrightnessSlider" = false;
        "notificationTimeoutLow" = 5000;
        "notificationTimeoutNormal" = 5000;
        "notificationTimeoutCritical" = 0;
        "notificationPopupPosition" = 0;
        "osdAlwaysShowValue" = false;
        "osdPosition" = 5;
        "osdVolumeEnabled" = true;
        "osdMediaVolumeEnabled" = true;
        "osdBrightnessEnabled" = true;
        "osdIdleInhibitorEnabled" = true;
        "osdMicMuteEnabled" = true;
        "osdCapsLockEnabled" = true;
        "osdPowerProfileEnabled" = false;
        "osdAudioOutputEnabled" = true;
        "powerActionConfirm" = true;
        "powerActionHoldDuration" = 0.5;
        "powerMenuActions" = [
          "reboot"
          "logout"
          "poweroff"
          "lock"
          "suspend"
          "restart"
        ];
        "powerMenuDefaultAction" = "logout";
        "powerMenuGridLayout" = false;
        "customPowerActionLock" = "";
        "customPowerActionLogout" = "";
        "customPowerActionSuspend" = "";
        "customPowerActionHibernate" = "";
        "customPowerActionReboot" = "";
        "customPowerActionPowerOff" = "";
        "updaterUseCustomCommand" = false;
        "updaterCustomCommand" = "";
        "updaterTerminalAdditionalParams" = "";
        "displayNameMode" = "system";
        "screenPreferences" = {
          "wallpaper" = [];
        };
        "showOnLastDisplay" = {};
        "barConfigs" = [
          {
            "id" = "default";
            "name" = "Main Bar";
            "enabled" = true;
            "position" = 0;
            "screenPreferences" = [
              "all"
            ];
            "showOnLastDisplay" = true;
            "leftWidgets" = [
              "launcherButton"
              "workspaceSwitcher"
              "focusedWindow"
            ];
            "centerWidgets" = [
              "music"
              "clock"
              "weather"
            ];
            "rightWidgets" = [
              "systemTray"
              "clipboard"
              "cpuUsage"
              "memUsage"
              "notificationButton"
              "battery"
              "controlCenterButton"
            ];
            "spacing" = 4;
            "innerPadding" = 4;
            "bottomGap" = 0;
            "transparency" = 0;
            "widgetTransparency" = 1;
            "squareCorners" = false;
            "noBackground" = false;
            "gothCornersEnabled" = false;
            "gothCornerRadiusOverride" = false;
            "gothCornerRadiusValue" = 12;
            "borderEnabled" = false;
            "borderColor" = "surfaceText";
            "borderOpacity" = 1;
            "borderThickness" = 1;
            "widgetOutlineEnabled" = false;
            "widgetOutlineColor" = "primary";
            "widgetOutlineOpacity" = 1;
            "widgetOutlineThickness" = 1;
            "fontScale" = 1.25;
            "autoHide" = false;
            "autoHideDelay" = 250;
            "openOnOverview" = false;
            "visible" = true;
            "popupGapsAuto" = true;
            "popupGapsManual" = 4;
            "maximizeDetection" = true;
          }
        ];
        "configVersion" = 2;
      };

      # plugins = {
      #   myPlugin = {
      #     enable = true;
      #     src = ./path/to/plugin;
      #   };
      # };
    };
  };
}
