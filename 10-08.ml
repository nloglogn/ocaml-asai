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
let lst5 = [person2;person3;person3]


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

(* 目的 : 数のリストを受け取り、その最大数を返す *)
(* max_list : int list -> int *)
let rec max_list lst = match lst with
    [] -> min_int
  | x :: rest -> let max_rest = max_list rest in
      if max_rest < x then x else max_rest

(* 目的 : 数のリストを受け取り、最大である要素の番号のリストを返す *)
(* max4list : int * int * int * int -> int list *)
let argmax lst = let maximum = max_list lst in
  let rec arg lst n =
    match lst with
        [] -> []
      | x :: rest -> let argmax_rest = arg rest (n + 1) in
        if x = maximum then n :: argmax_rest else argmax_rest
    in arg lst 0

(* 目的 : person_t型のリストを受け取り、最も人数の多かった血液型のリストを返す *)
(* saita_ketsueki : person_t list -> string list *)
let saita_ketsueki lst = let (a,b,o,ab) = ketsueki_shukei lst in
    let ketsueki_argmax = argmax [a;b;o;ab] in
    let rec pickup ketsueki_lst num_lst n = 
      match ketsueki_lst with
        [] -> []
      | x::rest -> match num_lst with
          [] -> []
        | num_x::num_rest -> if num_x = n then x :: pickup rest num_rest (n+1) else pickup rest num_lst (n+1)
    in pickup ["A";"B";"O";"AB"] ketsueki_argmax 0

(* テスト *)
let test1 = saita_ketsueki lst2 = ["A"]
let test2 = saita_ketsueki lst3 = ["A";"O"]
let test3 = saita_ketsueki lst4 = ["A";"O";"AB"]
let test4 = saita_ketsueki lst5 = ["AB"]
