open Stdint

type t = { x : unit }

let create () = { x = () }

let rec run_instruction ~(instr : uint32) =
  let i = Uint32.to_int instr in
  let bys = Bytes.create i in
  (* Bits 7:4 *)
  let prefix =
    Bytes.get bys 3 |> Char.code |> fun x -> Int.shift_right_logical x 4
  in
  (* Bits 27:20 *)
  let suffix =
    (Bytes.get bys 0 |> Char.code |> fun x -> x lsl 4)
    lor (Bytes.get bys 1 |> Char.code |> fun x -> x lsr 4)
  in
  begin
    match (prefix, suffix) with
    | x, y
      when (x = 00000000 || x = 00000001)
           && (y = 0b0000 || y = 0b0001 || y = 0b0010 || y = 0b0011
             || y = 0b0100 || y = 0b0101 || y = 0b0110 || y = 0b0111
             || y = 0b1000 || y = 0b1010 || y = 0b1100 || y = 0b1110) ->
        instr_and ~instr
    | _ -> Utils.unimplemented "cpu instr"
  end;
  Uint8.of_int 0

and instr_and ~(instr : uint32) = Utils.unimplemented "instr_and"
