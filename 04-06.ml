(* 目的: 与えられた鶴の数から足の本数を返す *)
(* tsuru_no_ashi : int -> int *)
let tsuru_no_ashi x = x * 2


(* テスト *)
let test1 = tsuru_no_ashi 2 = 4
let test2 = tsuru_no_ashi 4 = 8
let test3 = tsuru_no_ashi 10 = 20