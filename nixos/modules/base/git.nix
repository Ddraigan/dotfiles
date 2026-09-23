{...}: {
  homeManager.git = {...}: {
    programs = {
      git = {
        enable = true;
        settings = {
          user = {
            email = "lkjjones1999@gmail.com";
            name = "Ddraigan";
          };
          init.defaultBranch = "main";
        };
      };
    };
  };
}
