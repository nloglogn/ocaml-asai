type person_t = {
  name : string;          (* 名前 *)
  height : float;         (* 身長(m) *)
  weight : float;         (* 体重(kg) *)
  birthday : int * int;   (* 誕生日（月と日） *)
  bloodtype : string;     (* 血液型 *)
}

let person1 = {
  name = "A";
  height = 170.0;
  weight = 60.0;
  birthday = (6,2);
  bloodtype = "A";
}

let person2 = {
  name = "B";
  height = 168.0;
  weight = 56.0;
  birthday = (11,26);
  bloodtype = "O";
}

let person3 = {
  name = "C";
  height = 148.0;
  weight = 45.0;
  birthday = (1,1);
  bloodtype = "AB";
}
  (* person_t list 型のデータの例 *)
let lst1 = []
let lst2 = [person1]
let lst3 = [person2;person1]
let lst4 = [person2;person3;person1]

(* 目的 : person_t型の昇順のリストとperson_t型のデータを受け取ったら、それを挿入した昇順のリストを返す *)
(* person_insert : person_t list -> galiset_t -> person_t list *)
let rec person_insert lst person = match lst with
    [] -> [person]
  | ({name = n; height = h; weight = w; birthday = bd; bloodtype = bt} as x)::rest -> 
          (match person with
          {name = n2; height = h2; weight = w2; birthday = bd2; bloodtype = bt2} ->
            if n < n2 then x :: person_insert rest person else person :: lst)

(* 目的 : person_t型のリストを受け取ったら、点数の順に整列したリストを返す *)
(* person_sort : person_t list -> person_t list *)
let rec person_sort lst = match lst with
    [] -> []
  | x::rest -> person_insert (person_sort rest) x 


(* テスト *)
let test9 = person_sort lst1 = []
let test10 = person_sort lst2 = [person1]
let test11 = person_sort lst3 = [person1;person2]
let test12 = person_sort lst4 = [person1;person2;person3]
