(* 目的 : 配列を与えられたら、そこにフィボナッチ数を順に入れた配列を返す *)
(* fib_array : int array -> int array *)
let fib_array ar = let len = Array.length ar in
    if len = 0 then [||]
    else if len = 1 then [|0|]
    else if len = 2 then [|0;1|]
    else let rec fib_ar ar n = 
        (ar.(0) <- 0;
         ar.(1) <- 1;
        if n = len then ar
        else (ar.(n) <- ar.(n - 1) + ar.(n - 2); fib_ar ar (n+1)))
        in fib_ar ar 2



(* テスト *)
let test1 = fib_array [|0|] = [|0|]
let test2 = fib_array [|0;0|] = [|0;1|]
let test3 = fib_array [|0;0;0;0|] = [|0;1;1;2|]
let test4 = fib_array [|0;0;0;0;0;0;0;0;0;0|] = [|0;1;1;2;3;5;8;13;21;34|]