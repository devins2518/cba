open Tsdl

let or_err x =
  match x with
  | Error (`Msg e) ->
      Sdl.log "Error: %s" e;
      exit 1
  | Ok x -> x

let () =
  let w = 640 in
  let h = 480 in
  Sdl.init Sdl.Init.everything |> or_err;
  let window =
    Sdl.create_window ~w ~h "Camlboy Advance" Sdl.Window.opengl |> or_err
  in
  let renderer = Sdl.create_renderer window |> or_err in
  Sdl.set_render_draw_color renderer 0xFF 0xFF 0xFF 0xFF |> or_err;
  let texture =
    Sdl.create_texture renderer Sdl.Pixel.format_rgba8888
      Sdl.Texture.access_static ~w ~h
    |> or_err
  in
  let quit = ref false in
  while not !quit do
    let e = Sdl.Event.create () in
    if Sdl.poll_event (Some e) then
      if Sdl.Event.get e Sdl.Event.typ = Sdl.Event.quit then quit := true;
    Sdl.render_clear renderer |> or_err;
    Sdl.render_copy renderer texture |> or_err;
    Sdl.render_present renderer
  done;

  Sdl.destroy_texture texture;
  Sdl.destroy_renderer renderer;
  Sdl.destroy_window window;
  Sdl.quit ();
  exit 0
