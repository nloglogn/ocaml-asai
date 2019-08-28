#use "09-09-metro.ml"

type eki_t = {
  namae : string;
  saitan_kyori : float;
  temae_list : string list
}

(* 目的 : ekimei_t 型のリストと起点を受け取ったら、指定されたようにeki_tを書き換える *)
(* make_initial_eki_list : ekimwi_t list -> string -> eki_t list *)
let make_initial_eki_list lst kiten = List.map (fun {kanji=c; kana=k; romaji=r; shozoku=s}  ->
    if c = kiten then {namae=c; saitan_kyori=0.0; temae_list=[kiten]}
                 else {namae=c; saitan_kyori=infinity; temae_list=[]}) lst

(* 本問で作った無名関数は、問題14.11で作った2つの無名関数の合成関数である。 *)
