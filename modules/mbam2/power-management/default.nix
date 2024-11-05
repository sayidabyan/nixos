{...}:

{
    powerManagement.powertop.enable = false;
    services = {
        power-profiles-daemon.enable = false;
        tlp.enable = true;
        tlp.settings = {
          STOP_CHARGE_THRESH_BAT0 = 80;
          CPU_MIN_PERF_ON_AC = 0;
          CPU_MAX_PERF_ON_AC = 100;
          CPU_MIN_PERF_ON_BAT = 0;
          CPU_MAX_PERF_ON_BAT = 40;
        };
    };
}
