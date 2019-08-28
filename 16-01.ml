(* 目的 : 整数のリストを受け取ったら、それまでの数の合計からなるリストを返す *)
(* sum_list : int list -> int list *)
let sum_list lst = 
(* ここでiterは補助関数、accはそれまでの合計 *)
  let rec iter lst acc = match lst with
      [] -> []
    | first :: rest -> let next = (first + acc) in
      next :: iter rest next
  in iter lst 0

let test1 = sum_list [] = []
let test2 = sum_list [1] = [1]
let test3 = sum_list [1;2] = [1;3]
let test4 = sum_list [3;2;1;4] = [3;5;6;10]