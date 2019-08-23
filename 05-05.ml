(* 2次方程式 a x^2 + b x + c = 0 の係数 z,b,cを与えられたら、判別式の値を返す *)
(* hanbetsushiki : float -> float -> float -> float *)
let hanbetsushiki a b c = b *. b -. 4.0 *. a *. c

(* テスト *)
let test1 = hanbetsushiki 1.0 5.0 6.0 = 1.0
let test2 = hanbetsushiki 1.0 4.0 4.0 = 0.0
let test3 = hanbetsushiki 1.0 1.0 1.0 = -. 3.0


(* 目的 : 2次方程式 a x^2 + b x + c = 0 の係数 z,b,cを与えられたら、解の個数を返す *)
(* kai_no_kosuu : float -> float -> float -> int *)
(* ※虚数解も解に数えることとする。*)
let kai_no_kosuu a b c = if hanbetsushiki a b c = 0.0 then 1 else 2

(* テスト *)
let test1 = kai_no_kosuu 1.0 5.0 6.0 = 2
let test2 = kai_no_kosuu 1.0 4.0 4.0 = 1
let test3 = kai_no_kosuu 1.0 1.0 1.0 = 2
