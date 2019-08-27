type person_t = {
  name : string;          (* 名前 *)
  height : float;         (* 身長(m) *)
  weight : float;         (* 体重(kg) *)
  birthday : int * int;   (* 誕生日（月と日） *)
  bloodtype : string;     (* 血液型 *)
}

let person1 = {
  name = "一郎";
  height = 170.0;
  weight = 60.0;
  birthday = (6,2);
  bloodtype = "A";
}

let person2 = {
  name = "二郎";
  height = 168.0;
  weight = 56.0;
  birthday = (8,26);
  bloodtype = "O";
}

let person3 = {
  name = "三郎";
  height = 148.0;
  weight = 45.0;
  birthday = (9,1);
  bloodtype = "AB";
}

let lst1 = []
let lst2 = [person1]
let lst3 = [person1; person2]
let lst4 = [person1; person2; person3]

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

(* 目的 : person_t 型のリストを受け取り、血液型がA型の人の人数を返す *)
(* count_ketsueki_A : person_t list -> int *)
let rec otomeza lst = match lst with
    [] -> 0
  | {name = n; height = h; weight = w; birthday = (m,d); bloodtype = bt} :: rest
      -> if seiza m d = "おとめ座" then 1 + otomeza rest else otomeza rest


(* テスト *)
let test1 = otomeza lst1 = 0
let test2 = otomeza lst2 = 0
let test3 = otomeza lst3 = 1
let test4 = otomeza lst4 = 2
