
open Solver_types 
open Format

type exp = Atom of Solver_types.atom | Fresh of int

module S = 
  Set.Make
    (struct 
       type t = exp
       let compare a b = match a,b with
	 | Atom _, Fresh _ -> -1
	 | Fresh _, Atom _ -> 1
	 | Fresh i1, Fresh i2 -> i1 - i2
	 | Atom a, Atom b -> a.aid - b.aid
     end)
  
type t = S.t

let singleton e = S.singleton (Atom e)
    
let empty = S.empty

let union s1 s2 = S.union s1 s2

let iter_atoms f s = 
  S.iter (fun e -> match e with
    | Fresh _ -> ()
    | Atom a -> f a) s
      
let merge e1 e2 = e1


let fresh_exp =
  let r = ref (-1) in
  fun () -> incr r; !r

let remove_fresh i s =
  let fi = Fresh i in
  if S.mem fi s then Some (S.remove fi s)
  else None

let add_fresh i = S.add (Fresh i)

