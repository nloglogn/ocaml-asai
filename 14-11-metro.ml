#use "09-09-metro.ml"

type eki_t = {
  namae : string;
  saitan_kyori : float;
  temae_list : string list
}

(* 目的: ekimei_t 型のリストを受け取ったら、その駅名を使って eki_t 型のリストを作る *)
(* make_eki_list : ekimei_list -> eki_t list *)
let rec make_eki_list lst = List.map (fun {kanji=c; kana=k; romaji=r; shozoku=s} ->
            {namae=c; saitan_kyori=infinity; temae_list=[]}) lst

(* 目的 : eki_t 型のリストと起点を受け取ったら、指定されたようにeki_tを書き換える *)
(* shokika : eki_t list -> eki_t -> eki_t list *)
let shokika lst kiten = List.map (fun {namae=n; saitan_kyori=s; temae_list=t}  ->
    if n = kiten then {namae=n; saitan_kyori=0.0; temae_list=[kiten]}
                 else {namae=n; saitan_kyori=infinity; temae_list=[]}) lst

