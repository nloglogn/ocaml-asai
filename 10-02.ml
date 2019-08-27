(* 目的 : 昇順に並んでいる整数のリストlstと整数nを受け取ったら、昇順になるようにlstにnを挿入したリストを作る *)
(* insert : int list -> int -> int list *)
let rec insert lst n = match lst with
    [] -> [n]
  | first :: rest -> if first > n then n :: first :: rest else first :: insert rest n 

(* テスト *)
let test1 = insert [] 3 = [3]
let test2 = insert [2] 3 = [2;3]
let test3 = insert [4] 3 = [3;4]
let test4 = insert [1;2;3;4;5] 3 = [1;2;3;3;4;5]

(* 目的 : 整数のリストを受け取ったら、それを昇順に整列したリストを返す *)
(* ins_sort : int list -> int list *)
let rec ins_sort lst = match lst with
    [] -> []
  | x :: rest -> insert (ins_sort rest) x

(* テスト *)
let test5 = ins_sort [] = []
let test6 = ins_sort [1] = [1]
let test7 = ins_sort [2;1] = [1;2]
let test8 = ins_sort [1;5;2;4;3;7;6] = [1;2;3;4;5;6;7]
