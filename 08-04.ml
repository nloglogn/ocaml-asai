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

let person4 = {
  name = "四郎";
  height = 155.0;
  weight = 50.0;
  birthday = (3,30);
  bloodtype = "B";
}


(* 目的 : person_t型のデータを受け取ったら「○○さんの血液型は△△型です」という形の文字列を返す *)
(* ketsueki_hyoji : person_t -> string *)
let ketsueki_hyoji person = match person with
    {name = n; height = h; weight = w; birthday = bd; bloodtype = bt } ->
      n ^ "さんの血液型は" ^ bt ^ "型です"

(* テスト *)
let test1 = ketsueki_hyoji person1 = "一郎さんの血液型はA型です"
let test2 = ketsueki_hyoji person2 = "二郎さんの血液型はO型です"
let test3 = ketsueki_hyoji person3 = "三郎さんの血液型はAB型です"
let test4 = ketsueki_hyoji person4 = "四郎さんの血液型はB型です"