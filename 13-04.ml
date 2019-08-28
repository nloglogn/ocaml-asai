let compose f g = let h x = f (g x ) in h

let test = (compose (fun x -> x * 2) (fun x -> x + 3)) 4 = 14

(* 関数の型は、('a -> 'b) -> ('b -> 'c) -> ('a -> 'c) *)