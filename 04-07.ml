(* 目的: 与えられた弦の数と亀の数に対して足の数の合計を返す *)
(* tsurukame_no_ashi : int -> int -> int *)
let tsurukame_no_ashi t k = t * 2 + k * 4

(* テスト *)
let test1 = tsurukame_no_ashi 1 2 = 10
let test2 = tsurukame_no_ashi 2 1 = 8
let test3 = tsurukame_no_ashi 3 3 = 18