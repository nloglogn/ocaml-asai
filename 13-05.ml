let twice f = 
  let g x = f (f x)
  in g

let f = twice twice

let test = (f (fun x -> x + 3)) 7 = 19

(* fは、受け取った関数を4回適用する関数 *)
(* f の型は、 ('_weak1 -> '_weak1) -> '_weak1 -> '_weak1 *)