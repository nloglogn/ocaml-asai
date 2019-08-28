(* 目的 : 関数 f と初期値 init, リスト lst を受け取ったら、init から始めてリスト lst の要素を
  「左から」順に f を施し込む関数を作る *)
(* fold_left : ('a -> 'b -> 'a) -> 'a -> 'b list -> 'a *)
let rec fold_left f init lst = match lst with
    [] -> init
  | first :: rest -> fold_left f (f init first) rest

(* テスト *)

let test = let f x y = x * y + 2 in 
    fold_left f 1 [1;2;3;4;5] = List.fold_left f 1 [1;2;3;4;5]