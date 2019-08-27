(* 目的 : 漸化式 a_0 = 3, a_n = 2 a_{n-1} - 1 の第 n 項を求める *)
(* a : int -> int *)
let rec a n = 
  if n = 0 then 3
           else 2 * a (n - 1) - 1


(* テスト用の関数 *)
let f n =
  let rec power2 n = 
    if n = 0 then 1
    else 2 * power2 (n - 1)
  in power2 (n + 1) + 1

(* テスト *)
let test1 = a 0 = f 0
let test2 = a 1 = f 1
let test3 = a 2 = f 2
let test4 = a 4 = f 4
let test5 = a 50 = f 50