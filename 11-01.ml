(* 目的 : 0から受け取った自然数までの2乗の和を求める *)
(* sum_of_square : int -> int *)
let rec sum_of_square n = 
  if n = 0 then 0
           else n * n + sum_of_square (n - 1)


(* テスト用の関数 *)
let f n = n * (n + 1) * (2 * n + 1) / 6

(* テスト *)
let test1 = sum_of_square 0 = f 0
let test2 = sum_of_square 1 = f 1
let test3 = sum_of_square 2 = f 2
let test4 = sum_of_square 4 = f 4
let test5 = sum_of_square 100 = f 100