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
  birthday = (11,26);
  bloodtype = "O";
}

let person3 = {
  name = "三郎";
  height = 148.0;
  weight = 45.0;
  birthday = (1,1);
  bloodtype = "AB";
}

(* 目的 : person_t 型のリストを受けとったら、その中から指定された血液型の人数を返す *)
(* count_ketsueki *)
let rec count_ketsueki lst typ = match lst with
    [] -> 0
  | {name=n;height=h;weight=w;birthday=bd;bloodtype=bt}::rest ->
        if bt = typ then 1 + count_ketsueki rest typ else count_ketsueki rest typ


(* テスト *)
let lst1 = []
let lst2 = [person1]
let lst3 = [person1;person2]
let lst4 = [person1;person1;person1]

let test1 = count_ketsueki lst1 "A" = 0
let test2 = count_ketsueki lst2 "A" = 1
let test3 = count_ketsueki lst3 "B" = 0
let test4 = count_ketsueki lst4 "A" = 3