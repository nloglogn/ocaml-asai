(* 目的 : n から 1 までのリストを作る *)
(* enumerate : int -> int list *)
let rec enumerate n =
  if n = 0 then [] else n :: enumerate (n - 1)

(* 目的 : 階乗を求める *)
(* fac : int -> int *)
let fac n = List.fold_right ( * ) (enumerate n) 1 


(* テスト用関数 *)
let rec f n = if n = 0 then 1 else n * f (n - 1)

(* テスト *)
let test1 = fac 1 = f 1
let test2 = fac 2 = f 2
let test3 = fac 3 = f 3
let test4 = fac 4 = f 4
let test5 = fac 10 = f 10