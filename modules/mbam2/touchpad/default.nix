{...}:
{
  services.libinput = {
    enable = true;
    touchpad = {
      scrollMethod = "twofinger";
      tapping = false;
      naturalScrolling = true;
    };
  };
}

