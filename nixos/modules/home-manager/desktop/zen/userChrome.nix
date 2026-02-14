{colours}:
with colours; ''
    :root {
      --zen-colors-primary: ${hex.surface0} !important;
      --zen-primary-color: ${hex.pink} !important;
      --zen-colors-secondary: ${hex.surface0} !important;
      --zen-colors-tertiary: ${hex.mantle} !important;
      --zen-colors-border: ${hex.pink} !important;
      --toolbarbutton-icon-fill: ${hex.pink} !important;
      --lwt-text-color: ${hex.text} !important;
      --toolbar-field-color: ${hex.text} !important;
      --tab-selected-textcolor: ${hex.base} !important;
      --toolbar-field-focus-color: ${hex.text} !important;
      --toolbar-color: ${hex.text} !important;
      --newtab-text-primary-color: ${hex.text} !important;
      --arrowpanel-color: ${hex.text} !important;
      --arrowpanel-background: ${hex.base} !important;
      --sidebar-text-color: ${hex.text} !important;
      --lwt-sidebar-text-color: ${hex.text} !important;
      --lwt-sidebar-background-color: ${hex.base} !important;
      --toolbar-bgcolor: ${hex.surface0} !important;
      --newtab-background-color: ${hex.base} !important;
      --zen-themed-toolbar-bg: ${hex.base} !important;
      --zen-main-browser-background: transparent !important;
      --toolbox-bgcolor-inactive: ${hex.mantle} !important;
      --toolbox-textcolor: ${hex.text} !important;
    }

    #permissions-granted-icon {
      color: ${hex.text} !important;
    }

    .sidebar-placesTree {
      background-color: transparent !important;
    }

    #sidebar-box {
      background-color: transparent !important;
    }

    #zen-workspaces-button {
      background-color: transparent !important;
    }

    .tab-text {
        color: ${hex.text} !important;
      }

    .tabbrowser-tab[selected] .tab-background {
        background-color: ${rgba rgb.flamingo 0.4} !important;
    }

    .tab-label-container[selected] label {
        color: ${hex.text} !important;
    }

    .urlbar-background {
      background-color: ${hex.surface0} !important;
    }

    .content-shortcuts {
      background-color: ${hex.base} !important;
      border-color: ${hex.pink} !important;
    }

    .urlbarView-url {
      color: ${hex.flamingo} !important;
    }

    .urlbarView-row {
        color: ${hex.text} !important;
      }

    #urlbar-input::selection {
      background-color: ${hex.pink} !important;
      color: ${hex.base} !important;
    }

    #zenEditBookmarkPanelFaviconContainer {
      background: ${hex.base} !important;
    }

    #zen-media-controls-toolbar {
      & #zen-media-progress-bar {
        &::-moz-range-track {
          background: ${hex.surface0} !important;
        }
      }
    }

    toolbar .toolbarbutton-1 {
      &:not([disabled]) {
        &:is([open], [checked])
          > :is(
            .toolbarbutton-icon,
            .toolbarbutton-text,
            .toolbarbutton-badge-stack
          ) {
          fill: ${hex.base};
        }
      }
    }

  .zen-workspace-icon {
    background: ${hex.pink};
  }

    .identity-color-blue {
      --identity-tab-color: ${hex.blue} !important;
      --identity-icon-color: ${hex.blue} !important;
    }

    .identity-color-turquoise {
      --identity-tab-color: ${hex.teal} !important;
      --identity-icon-color: ${hex.teal} !important;
    }

    .identity-color-green {
      --identity-tab-color: ${hex.green} !important;
      --identity-icon-color: ${hex.green} !important;
    }

    .identity-color-yellow {
      --identity-tab-color: ${hex.yellow} !important;
      --identity-icon-color: ${hex.yellow} !important;
    }

    .identity-color-orange {
      --identity-tab-color: ${hex.peach} !important;
      --identity-icon-color: ${hex.peach} !important;
    }

    .identity-color-red {
      --identity-tab-color: ${hex.red} !important;
      --identity-icon-color: ${hex.red} !important;
    }

    .identity-color-pink {
      --identity-tab-color: ${hex.mauve} !important;
      --identity-icon-color: ${hex.mauve} !important;
    }

    .identity-color-purple {
      --identity-tab-color: ${hex.flamingo} !important;
      --identity-icon-color: ${hex.flamingo} !important;
    }

    #navigator-toolbox {
      --zen-main-browser-background-toolbar: transparent !important;
    }

    #zen-appcontent-navbar-container {
      background-color: ${hex.base} !important;
    }

    #contentAreaContextMenu menu,
    menuitem,
    menupopup {
      color: ${hex.text} !important;
    }
''
# #TabsToolbar {
#   background-color: transparent !important;
# }

