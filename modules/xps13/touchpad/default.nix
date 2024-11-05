{...}:
{
  services.libinput = {
    enable = true;
    touchpad = {
      scrollMethod = "twofinger";
      tapping = true;
      naturalScrolling = true;
    };
  };
}

