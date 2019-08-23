type okozukai_t = {
  name : string;    (*買ったものの名前 *)
  price : int;      (* 値段 *)
  place : string;   (* 買った場所 *)
  data : string;    (* 日付 *)
}

let okozukai1 = {
  name = "消しゴム";
  price = 100;
  place = "スーパー";
  data = "2019-08-23";
}
let okozukai2 = {
  name = "ボールペン";
  price = 150;
  place = "本屋";
  data = "2019-08-21";
}
let okozukai3 = {
  name = "ポテトチップス";
  price = 120;
  place = "コンビニ";
  data = "2019-08-19";
}