{colours}:
with colours; ''
  /* Common variables affecting all pages */
  @-moz-document url-prefix("about:") {
    :root {
      --in-content-page-color: ${hex.text} !important;
      --color-accent-primary: ${hex.blue} !important;
      --color-accent-primary-hover: ${hex.blue} !important;
      --color-accent-primary-active: ${hex.blue} !important;
      background-color: ${hex.base} !important;
      --in-content-page-background: ${hex.base} !important;
    }
  }

  /* Variables and styles specific to about:newtab and about:home */
  @-moz-document url("about:newtab"), url("about:home") {

    :root {
      --newtab-background-color: ${hex.base} !important;
      --newtab-background-color-secondary: ${hex.surface0} !important;
      --newtab-element-hover-color: ${hex.surface0} !important;
      --newtab-text-primary-color: ${hex.text} !important;
      --newtab-wordmark-color: ${hex.text} !important;
      --newtab-primary-action-background: ${hex.blue} !important;
    }

    .icon {
      color: ${hex.blue} !important;
    }

    .search-wrapper .logo-and-wordmark .logo {
      display: inline-block !important;
      height: 82px !important;
      width: 82px !important;
      background-size: 82px !important;
    }

    @media (max-width: 609px) {
      .search-wrapper .logo-and-wordmark .logo {
        background-size: 64px !important;
        height: 64px !important;
        width: 64px !important;
      }
    }

    .card-outer:is(:hover, :focus, .active):not(.placeholder) .card-title {
      color: ${hex.blue} !important;
    }

    .top-site-outer .search-topsite {
      background-color: ${hex.blue} !important;
    }

    .compact-cards .card-outer .card-context .card-context-icon.icon-download {
      fill: ${hex.green} !important;
    }
  }

  /* Variables and styles specific to about:preferences */
  @-moz-document url-prefix("about:preferences") {
    :root {
      --zen-colors-tertiary: ${hex.mantle} !important;
      --in-content-text-color: ${hex.text} !important;
      --link-color: ${hex.blue} !important;
      --link-color-hover: ${hex.blue} !important;
      --zen-colors-primary: ${hex.surface0} !important;
      --in-content-box-background: ${hex.surface0} !important;
      --zen-primary-color: ${hex.blue} !important;
    }

    groupbox , moz-card{
      background: ${hex.base} !important;
    }

    button,
    groupbox menulist {
      background: ${hex.surface0} !important;
      color: ${hex.text} !important;
    }

    .main-content {
      background-color: ${hex.base} !important;
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
  }

  /* Variables and styles specific to about:addons */
  @-moz-document url-prefix("about:addons") {
    :root {
      --zen-dark-color-mix-base: ${hex.mantle} !important;
      --background-color-box: ${hex.base} !important;
    }
  }

  /* Variables and styles specific to about:protections */
  @-moz-document url-prefix("about:protections") {
    :root {
      --zen-primary-color: ${hex.base} !important;
      --social-color: ${hex.mauve} !important;
      --coockie-color: ${hex.blue} !important;
      --fingerprinter-color: ${hex.yellow} !important;
      --cryptominer-color: ${hex.flamingo} !important;
      --tracker-color: ${hex.green} !important;
      --in-content-primary-button-background-hover: ${hex.surface1} !important;
      --in-content-primary-button-text-color-hover: ${hex.text} !important;
      --in-content-primary-button-background: ${hex.surface1} !important;
      --in-content-primary-button-text-color: ${hex.text} !important;
    }

    .card {
      background-color: ${hex.surface0} !important;
    }
  }

  ::selection {
    background-color: ${hex.surface0} !important;
    color: ${hex.text} !important;
  }
''
