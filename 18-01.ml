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

(* 目的 : person_t 型のリストを受け取ったら、最初のA型の人のレコードをオプション型で返す *)
(* first_A : person_t list -> person_t *)
let rec first_A lst = match lst with
    [] -> None
  | first :: rest -> match first with
      {name=n;height=h;weight=w;birthday=bd;bloodtype=bt} ->
          if bt = "A" then Some (first) else first_A rest

(* テスト *)
let lst1 = []
let lst2 = [person1]
let lst3 = [person2;person1]
let lst4 = [person2;person1;person3]

let test1 = first_A lst1 = None
let test2 = first_A lst2 = Some (person1)
let test3 = first_A lst3 = Some (person1)
let test4 = first_A lst4 = Some (person1)