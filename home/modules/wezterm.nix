{ pkgs, ... }:

{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      return {
        config.font = wezterm.font 'JetBrains Mono'
        config.font_size = 16.0
        config.line_height = 1.2
        config.color_scheme = 'tokyonight_night'


        config.window_background_opacity = 0.9
        config.macos_window_background_blur = 20
        config.hide_tab_bar_if_only_one_tab = true

        config.max_fps = 120  -- Fixes perceived slowness [7]
        config.enable_wayland = false  -- Better macOS perf
      }
    '';
  };
}
