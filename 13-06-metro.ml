#use "09-10-metro.ml"

type eki_t = {
  namae : string;
  saitan_kyori : float;
  temae_list : string list
}

(* 目的 : 漢字の駅名をふたつと駅間リストを受け取ったら、その2駅間の距離を返す *)
(* get_ekikan_kyori : string -> string -> ekikan_t list -> float *)
let rec get_ekikan_kyori ekimei1 ekimei2 ekikan_list = match ekikan_list with
    [] -> infinity
  | {kiten = k; shuten = s; keiyu = _; kyori = d; jikan = _}::rest -> 
      if (k = ekimei1 && s = ekimei2) || (k = ekimei2 && s = ekimei1) then d
      else get_ekikan_kyori ekimei1 ekimei2 rest

(* 目的 : 駅p (eki_t 型) と駅q (elo_t 型)を受け取ったら、oとqが直接つながっているかを調べ、つながっていたら
　qの最短距離と手前リストを必要に応じて更新したものを返す *)
(* koushin1 : eki_t -> eki_t *)
let koushin1 ({namae=n1;saitan_kyori=s1;temae_list=t1} as p) ({namae=n2;saitan_kyori=s2;temae_list=t2} as q) =
  if n1 = "" then failwith "first station not found"
  else if 2 = "" then "second station not found"
  else let kyori = get_ekikan_kyori n1 n2 global_ekikan_list in
  if kyori = infinity then q
  else let temp_kyori = s1 + kyori in if s2 <= temp_kyori then q
       else {namae=s2;saitan_kyori=temp_kyori;temae=p::t2}