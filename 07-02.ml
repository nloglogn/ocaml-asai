(* 目的 : 名前と成績の組を受け取り、メッセージを返す *)
(* seiseki : string * string -> string *)
let seiseki (name, grade) = name ^ "さんの評価は" ^ grade ^ "です"


(* テスト *)
let test = seiseki ("浅井", "A+") = "浅井さんの評価はA+です"