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

(* 目的 : person_t 型のデータのリストを受け取り、各血液型の人数の組を返す *)
(* ketsueki_shukei person_t list -> int * int * int * int *)
let rec ketsueki_shukei lst = match lst with
      [] -> (0,0,0,0)
    | {name = n; height = h; weight = w; birthday = bd; bloodtype = bt}::rest -> 
    let (a,b,o,ab) = ketsueki_shukei rest in
      if bt = "A" then (a + 1, b, o, ab)
      else if bt = "B" then (a, b + 1, o, ab)
      else if bt = "O" then (a, b, o + 1, ab)
      else (a, b, o, ab + 1)


(* テスト *)
let test1 = ketsueki_shukei lst1 = (0,0,0,0)
let test2 = ketsueki_shukei lst2 = (1,0,0,0)
let test3 = ketsueki_shukei lst3 = (1,0,1,0)
let test4 = ketsueki_shukei lst4 = (1,0,1,1)
