(* 1 *)
let f1 x = x

(* 2 *)
let f2 x y = x

(* 3 *)
let f3 x y = y

(* 4 *)
let f4 x f = f x

(* 5 *)
let f5 f g = let h x = g (f x ) in h