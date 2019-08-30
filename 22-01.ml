let num = ref (-1)

(* 目的 : 文字列を受け取ったら、その文字列に呼ばれるごとに異なる数字を付けた文字列を返す *)
(* gensym : int -> int *)
let gensym s = 
  (num := !num + 1;
  s ^ string_of_int !num)

(* テスト *)
let test1 = gensym "a" = "a0"
let test2 = gensym "b" = "b1"
let test3 = gensym "c" = "c2"
let test4 = gensym "d" = "d3"