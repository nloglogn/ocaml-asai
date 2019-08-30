(* 目的 : 受け取ったfirst::restの最小値を返す *)
(* minimum : int -> int list -> int *)
let rec minimum first rest = match rest with
    [] -> first
  | second::rest' -> let min' = minimum second rest' in
      if first < min' then first else min'


(* テスト *)
let test1 = minimum 3 [] = 3
let test2 = minimum 2 [3] = 2
let test3 = minimum 3 [2] = 2
let test4 = minimum 5 [2;7;4;6;8;9;1;3] = 1
