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
  Sdl.init Sdl.Init.video |> or_err;
  let window =
    Sdl.create_window ~w ~h "Camlboy Advance" Sdl.Window.opengl |> or_err
  in
  Sdl.delay 3000l;
  Sdl.destroy_window window;
  Sdl.quit ();
  exit 0
