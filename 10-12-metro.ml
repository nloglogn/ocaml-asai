#use "09-09-metro.ml"
#use "09-10-metro.ml"


(* 目的 : ローマ字の駅名と駅名リストを受け取ったら、その駅の漢字表記を文字列で返す *)
(* romaji_to_kanji : string -> ekimei_t -> string *)
let rec romaji_to_kanji ekimei ekimei_list = match ekimei_list with
    [] -> ""
  | {kanji = c; kana = k; romaji = r; shozoku = s}::rest ->
    if r = ekimei then c else romaji_to_kanji ekimei rest

(* 目的 : 漢字の駅名をふたつと駅間リストを受け取ったら、その2駅間の距離を返す *)
(* get_ekikan_kyori : string -> string -> ekikan_t list -> float *)
let rec get_ekikan_kyori ekimei1 ekimei2 ekikan_list = match ekikan_list with
    [] -> infinity
  | {kiten = k; shuten = s; keiyu = _; kyori = d; jikan = _}::rest -> 
      if (k = ekimei1 && s = ekimei2) or (k = ekimei2 && s = ekimei1) then d
      else get_ekikan_kyori ekimei1 ekimei2 rest

(* 目的 : ローマ字の駅名をふたつ受け取って、その間の距離を調べてメッセージ形式で出力する *)
(* kyori_wo_hyoji: string -> string -> string *)
let kyori_wo_hyoji romaji1 romaji2 =
  let kanji1 = romaji_to_kanji romaji1 global_ekimei_list
  and kanji2 = romaji_to_kanji romaji2 global_ekimei_list in
  if kanji1 = "" then romaji1 ^ "という駅は存在しません"
  else if kanji2 = "" then romaji2 ^ "という駅は存在しません"
  else let kyori = get_ekikan_kyori kanji1 kanji2 global_ekikan_list in
  if kyori = infinity then kanji1 ^ "駅と" ^ kanji2 ^ "駅はつながっていません"
  else kanji1 ^ "駅から" ^ kanji2 ^ "駅までは" ^ (string_of_float kyori) ^ "kmです"

(* テスト *)
let test1 = kyori_wo_hyoji "myogadani" "shinotsuka" = "茗荷谷駅から新大塚駅までは1.2kmです"
let test2 = kyori_wo_hyoji "myogadani" "ueno" = "茗荷谷駅と上野駅はつながっていません"
let test3 = kyori_wo_hyoji "myogadani" "kisaragi" = "kisaragiという駅は存在しません"