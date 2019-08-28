(* 目的 : 整数を受け取ったら、それが偶数かどうかを判定する *)
(* is_even : int -> bool *)
let is_even n = n mod 2 = 0
  
(* 目的 : 整数のリストを受け取ったら、その中の偶数の要素のみを含むリストを返す *)
(* even : int list -> int list *)
let even lst = List.filter is_even lst

(* テスト *)
let test1 = even [] = []
let test2 = even [2] = [2]
let test3 = even [1;3] = []
let test4 = even [1;2;3;4;5;6;7;8;9;0] = [2;4;6;8;0]
