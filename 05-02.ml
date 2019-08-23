(* 目的：受けとった時間に対して、それが午前か午後かを返す *)
(* jikan int -> string *)
let jikan hour = if hour < 12 then "午前"
  else "午後"


(* テスト *)
let test1 = jikan 7 = "午前"
let test2 = jikan 15 = "午後"
let test3 = jikan 12 = "午後"