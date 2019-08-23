(* 目的 : 月と日を受け取ったら、星座を返す *)
(* seiza : int -> int -> string *)
let seiza m d = if m = 0
  then ""
  else if m = 1 then
    if d < 20 then "やぎ座" else "みずがめ座"
  else if m = 2 then
  if d < 19 then "みずがめ座" else "うお座"
  else if m = 3 then
  if d < 20 then "うお座" else "おひつじ座"
  else if m = 4 then
  if d < 20 then "おひつじ座" else "おうし座"
  else if m = 5 then
  if d < 21 then "おうし座" else "ふたご座"
  else if m = 6 then
  if d < 22 then "ふたご座" else "かに座"
  else if m = 7 then
  if d < 23 then "かに座" else "しし座"
  else if m = 8 then
  if d < 23 then "しし座" else "おとめ座"
  else if m = 9 then
  if d < 23 then "おとめ座" else "てんびん座"
  else if m = 10 then
  if d < 24 then "てんびん座" else "さそり座"
  else if m = 11 then
  if d < 23 then "さそり座" else "いて座"
  else 
  if d < 22 then "いて座" else "やぎ座"
  


(* テスト *)
let test01 = seiza 3 21 = "おひつじ座"
let test02 = seiza 5 5 = "おうし座"
let test03 = seiza 6 9 = "ふたご座"
let test04 = seiza 7 15 = "かに座"
let test05 = seiza 7 24 = "しし座"
let test06 = seiza 9 22 = "おとめ座"
let test07 = seiza 10 10 = "てんびん座"
let test08 = seiza 11 22 = "さそり座"
let test09 = seiza 12 1 = "いて座"
let test10 = seiza 1 1 = "やぎ座"
let test11 = seiza 1 28 = "みずがめ座"
let test12 = seiza 3 3 = "うお座"
