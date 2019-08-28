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

(* 目的 : person_t 型のデータを受け取ってきたら、その名前フィールドを取り出す無名関数を作る *)
(* f : person_t -> string *)
let f = fun {name=n;height=h;weight=w;birthday=bd;bloodtype=bt} -> n

let test1 = f person1 = "一郎"
let test2 = f person2 = "二郎"
let test3 = f person3 = "三郎"