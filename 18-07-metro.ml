#use "09-09-metro.ml"

exception No_such_station of string


(* 目的 : ローマ字の駅名と駅名リストを受け取ったら、その駅の漢字表記を文字列で返す *)
(* romaji_to_kanji : string -> ekimei_t -> string *)
let rec romaji_to_kanji ekimei ekimei_list = match ekimei_list with
    [] -> raise (No_such_station (ekimei))
  | {kanji = c; kana = k; romaji = r; shozoku = s}::rest ->
    if r = ekimei then c else romaji_to_kanji ekimei rest

let test1 = romaji_to_kanji "myogadani" global_ekimei_list = "茗荷谷"
let test2 = romaji_to_kanji "sapporo" global_ekimei_list (* ← No_such_station *)