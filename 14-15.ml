(* 目的 : n から 1 までのリストを作る *)
(* enumerate : int -> int list *)
let rec enumerate n =
  if n = 0 then [] else n :: enumerate (n - 1)

(* 目的 : 1 から受け取った自然数うまでの合計を求める *)
(* one_to_n : int -> int *)
let one_to_n n = List.fold_right (+) (enumerate n) 0


(* テスト用関数 *)
let f n = n * (n + 1) / 2

(* テスト *)
let test1 = one_to_n 1 = f 1
let test2 = one_to_n 2 = f 2
let test3 = one_to_n 3 = f 3
let test4 = one_to_n 4 = f 4
let test5 = one_to_n 100 = f 100