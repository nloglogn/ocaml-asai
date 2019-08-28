(* first を文字列 rest_result に結合する *)
let conc_string first rest_result = first ^ rest_result

(* 目的 : 文字列のリストを受け取ったら、その中の要素をくっつけた文字列を返す *)
(* concat : string list -> string *)
let concat lst = List.fold_right conc_string lst ""

(* テスト *)
let test1 = concat [] = ""
let test2 = concat ["2"] = "2"
let test3 = concat ["春";"夏";"秋";"冬"] = "春夏秋冬"
