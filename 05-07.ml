let bmi height weight = weight /. (height ** 2.0);;

(* 目的 : 身長(m)と体重(kg)を与えられたら、BMI指数を計算し、その数値によって体型を返す *)
(* taikei : float -> float -> string *)
let taikei height weight = 
  if bmi height weight < 18.5 then "やせ"
  else if bmi height weight < 25.0 then "標準"
  else if bmi height weight < 30.0 then "肥満"
  else "高度肥満"
  

(* テスト *)
let test1 = taikei 1.7 50.0 = "やせ"
let test2 = taikei 1.7 60.0 = "標準"
let test3 = taikei 1.7 75.0 = "肥満"
let test4 = taikei 1.7 100.0 = "高度肥満"
