(* 駅名の情報を格納するレコード型 *)
type ekimei_t = {
  kanji : string;   (* 漢字の駅名 *)
  kana : string;    (* ひらがなの駅名 *)
  romaji : string;  (* ローマ字の駅名 *)
  shozoku : string; (* 所属する路線名 *)
}

(* 目的 : ekimei_t型のデータに対して、「路線名、駅名（かな）」の形式の文字列を返す *)
(* hyoji : ekimei_t -> string *)
let hyoji eki = match eki with
    {kanji = c; kana = k; romaji = r; shozoku = s} ->
      s ^ "、" ^ c ^ "（" ^ k ^ "）"


(* テスト *)
let test1 = hyoji {kanji = "茗荷谷"; kana = "みょうがだに"; romaji = "myogadani"; shozoku = "丸ノ内線"}
          = "丸ノ内線、茗荷谷（みょうがだに）"
let test2 = hyoji {kanji = "本八幡"; kana = "もとやわた"; romaji = "motoyawata"; shozoku = "都営新宿線"}
          = "都営新宿線、本八幡（もとやわた）"
let test3 = hyoji {kanji = "錦糸町"; kana = "きんしちょう"; romaji = "kinshicho"; shozoku = "半蔵門線"}
          = "半蔵門線、錦糸町（きんしちょう）"
