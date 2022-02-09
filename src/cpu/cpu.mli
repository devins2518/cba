open Stdint

type t

val create : unit -> t

val run_instruction : instr:uint32 -> uint8
(** Takes an instruction, parses it, and returns the clocks cycled *)
