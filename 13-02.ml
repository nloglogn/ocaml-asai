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

(* 目的: person_t 型のリストを受け取ったら、その中に出てくる人の名前のリストを返す *)
(* person_namae : person_t list -> string list *)
let person_namae lst = List.map (fun {name=n;height=h;weight=w;birthday=bd;bloodtype=bt} -> n) lst

(* テスト *)
let lst1 = []
let lst2 = [person1]
let lst3 = [person1;person2]
let lst4 = [person1;person2;person3]

let test1 = person_namae lst1 = []
let test2 = person_namae lst2 = ["一郎"]
let test3 = person_namae lst3 = ["一郎";"二郎"]
let test4 = person_namae lst4 = ["一郎";"二郎";"三郎"]