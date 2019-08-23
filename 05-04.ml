(* 2次方程式 a x^2 + b x + c = 0 の係数 z,b,cを与えられたら、判別式の値を返す *)
(* hanbetsushiki : float -> float *)
let hanbetsushiki a b c = b *. b -. 4.0 *. a *. c


(* テスト *)
let test1 = hanbetsushiki 1.0 5.0 6.0 = 1.0
let test2 = hanbetsushiki 1.0 4.0 4.0 = 0.0
let test3 = hanbetsushiki 1.0 1.0 1.0 = -. 3.0