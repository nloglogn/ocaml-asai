#use "09-09-metro.ml"

type eki_t = {
  namae : string;
  saitan_kyori : float;
  temae_list : string list
}

(* 目的: ekimei_t 型のリストを受け取ったら、その駅名を使って eki_t 型のリストを作る *)
(* make_eki_list : ekimei_list -> eki_t list *)
let make_eki_list {kanji=c; kana=k; romaji=r; shozoku=s} = {namae=c; saitan_kyori=infinity; temae_list=[]}


(* テスト *)
let test1 = make_eki_list {kanji="代々木上原"; kana="よよぎうえはら"; romaji="yoyogiuehara"; shozoku="千代田線"}
            = {namae="代々木上原"; saitan_kyori=infinity; temae_list=[]}
let test2 = make_eki_list {kanji="代々木公園"; kana="よよぎこうえん"; romaji="yoyogikouen"; shozoku="千代田線"}
            = {namae="代々木公園"; saitan_kyori=infinity; temae_list=[]}
let test3 = make_eki_list {kanji="明治神宮前"; kana="めいじじんぐうまえ"; romaji="meijijinguumae"; shozoku="千代田線"}
            = {namae="明治神宮前"; saitan_kyori=infinity; temae_list=[]}