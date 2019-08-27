(* 目的 : 2つのリストを受け取ったら、それらの長さが同じかどうかを判定する *)
(* equal_length : 'a list -> 'b list -> bool *)
let rec equal_length lst1 lst2 =
  match (lst1,lst2) with
      ([],[]) -> true
    | (_::_,[]) -> false
    | ([],_::_) -> false
    | (_::rest1,_::rest2) -> equal_length rest1 rest2

(* テスト *)
let test1 = equal_length [] [] = true
let test2 = equal_length [1] [] = false
let test3 = equal_length [] [2] = false
let test4 = equal_length [1;2] [3;4] = true
let test5 = equal_length [1;2;3] [4;5] = false
let test6 = equal_length [1;2] [3;4;5] = false
