window.onModuleReady = function () {
  var win = Module._j_init_window();
  var renderer = Module._j_init_renderer(win);
  if (!win || !renderer) {
    console.error("Failed to initialize SDL");
    return;
  }
  var state = Module._j_init_game_state(renderer, win);
  if (!state) {
    console.error("Failed to initialize game state");
    return;
  }
  function frame() {
    Module._game_loop(state, renderer, win);
    requestAnimationFrame(frame);
  }
  requestAnimationFrame(frame);
};
