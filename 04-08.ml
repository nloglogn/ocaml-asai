(* 目的 : 鶴と亀の数の合計と足の本数の合計を与えられたら、鶴の数を返す *)
(* tsurukame : int -> int -> int *)
let tsurukame x y = 2 * x - y / 2


(* テスト *)
let test1 = tsurukame 3 10 = 1
let test2 = tsurukame 3 8 = 2
let test3 = tsurukame 6 18 = 3