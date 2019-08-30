#use "09-09-metro.ml"
#use "09-10-metro.ml"

type eki_t = {
  namae : string;
  saitan_kyori : float;
  temae_list : string list
}

type ekikan_tree_t = Empty | Node of ekikan_tree_t * string * (string * float) list * ekikan_tree_t

(* 目的 : ekikan_tree_t 型の木と ekikan_t 型の駅間を受け取り、その情報を挿入した木を返す *)
(* insert_ekikan : ekikan_tree_t -> ekikan_t -> ekikan_tree_t *)
let insert_ekikan tree {kiten=k;shuten=s;keiyu=v;kyori=d;jikan=t} = 
    let rec insert tree eki1 eki2 kyori = match tree with
        Empty -> Node (Empty, eki1, [(eki2,kyori)], Empty)
      | Node (t1, x, lst, t2) ->
          if eki1 < x then Node (insert t1 eki1 eki2 kyori, x, lst, t2)
          else if x < eki1 then Node (t1, x, lst, insert t2 eki1 eki2 kyori)
          else Node (t1, x, (eki2,kyori)::lst, t2)
    in let inserted_half = insert tree k s d
    in insert inserted_half s k d

(* 目的 : ekikan_tree_t 型の木と ekikan_t list 型の駅間リストを受け取り、リストの中に含まれる駅間を
          すべて挿入した木を返す *)
(* inserts_ekikan : ekikan_tree_t -> ekikan_t list -> ekika_tree_t *)
let inserts_ekikan tree ekikan_list = List.fold_left insert_ekikan tree ekikan_list

(* 目的 : ekimei_t 型のリストを受け取ったら、それをひらがなの順に整列し、駅の重複を取り除いたリストを返す *)
(* seiretsu : ekimei_t list -> ekimei_t list *)
let seiretsu lst = 
  let rec insert lst ({kanji=c;kana=k;romaji=r;shozoku=s} as eki) = match lst with
      [] -> [eki]
    | ({kanji=c1;kana=k1;romaji=r1;shozoku=s1} as eki1)::rest -> 
        if k1 > k then eki :: lst else eki1 :: insert rest eki
  in let rec eki_sort lst = match lst with
      [] -> []
    | first :: rest -> insert (eki_sort rest) first
  in let sorted_lst = eki_sort lst
  in let rec reduce lst = match lst with
      [] -> []
    | [x] -> [x]
    | ({kanji=c1;kana=k1;romaji=r1;shozoku=s1} as eki1)::({kanji=c2;kana=k2;romaji=r2;shozoku=s2} as eki2)::rest ->
        if k1 = k2 then reduce (eki2 :: rest) else eki1 :: reduce (eki2 :: rest)
  in reduce sorted_lst

(* 目的 : ローマ字の駅名と駅名リストを受け取ったら、その駅の漢字表記を文字列で返す *)
(* romaji_to_kanji : string -> ekimei_t -> string *)
let rec romaji_to_kanji ekimei ekimei_list = match ekimei_list with
    [] -> ""
  | {kanji = c; kana = k; romaji = r; shozoku = s}::rest ->
    if r = ekimei then c else romaji_to_kanji ekimei rest

(* 目的 : ekimei_t 型のリストと起点を受け取ったら、指定されたようにeki_tを書き換える *)
(* make_initial_eki_list : ekimwi_t list -> string -> eki_t list *)
let make_initial_eki_list lst kiten = List.map (fun {kanji=c; kana=k; romaji=r; shozoku=s}  ->
    if c = kiten then {namae=c; saitan_kyori=0.0; temae_list=[kiten]}
                 else {namae=c; saitan_kyori=infinity; temae_list=[]}) lst

(* 目的 : 漢字の駅名2つと ekikan_tree_t 型の木を受け取り、その2駅間の距離を返す *)
(* get_ekikan_kyori : string -> string -> ekikan_tree_t -> float *)
let rec get_ekikan_kyori ekimei1 ekimei2 ekikan_tree = match ekikan_tree with
    Empty -> infinity
  | Node (t1, x, lst, t2) -> if ekimei1 < x then get_ekikan_kyori ekimei1 ekimei2 t1
        else if x < ekimei1 then get_ekikan_kyori ekimei1 ekimei2 t2
        else let rec match_ekimei ekimei lst =  match lst with
                  [] -> infinity
                | (n,d) :: rest -> if n = ekimei then d else match_ekimei ekimei rest
             in match_ekimei ekimei2 lst


(* 目的 : 駅p (eki_t 型) と未確定の駅のリスト v (eki_t list 型) を受け取ったら、必要な更新処理を
　行った後の未確定の駅のリストを返す *)
(* koushin : eki_t -> eki_t list -> ekikan_tree_t -> eki_t list *)
let koushin p v tree = List.map ((fun {namae=n1;saitan_kyori=s1;temae_list=t1} ({namae=n2;saitan_kyori=s2;temae_list=t2} as q) ->
  if n1 = "" then failwith "first station not found"
  else if n2 = "" then failwith "second station not found"
  else let kyori = get_ekikan_kyori n1 n2 tree in
  if kyori = infinity then q
  else let temp_kyori = s1 +. kyori in if s2 <= temp_kyori then q
   else {namae=n2;saitan_kyori=temp_kyori;temae_list=n2::t1}) p) v

(* 目的 : eki_t list 型のリストを受け取ったら、「最短距離最小の駅」と
    「最短距離最小の駅以外からなるリスト」の組を返す *)
(* saitan_wo_bunri : eki_t list -> eki_t * eki_t list *)
let saitan_wo_bunri lst = 
  let rec minimum_kyori lst = match lst with
      [] -> max_float
    | {namae=n;saitan_kyori=s;temae_list=t} :: rest -> 
      let min_rest = minimum_kyori rest in
        if s < min_rest then s else min_rest in
  let min_lst = minimum_kyori lst in
  let rec argmin lst min_value = 
      match lst with
          [] -> failwith "data not found" 
        | [p] -> p
        | ({namae=n;saitan_kyori=s;temae_list=t} as p) :: rest ->
            if s = min_value then p else argmin rest min_value in
  let removed = argmin lst min_lst in
  let rec remove lst removed = match lst with
          [] -> failwith "data not found"
        | first :: rest -> if first = removed then rest else first :: remove rest removed in
      (removed, remove lst removed)

(* 目的 : eki_t list 型の（未確定の）駅のリストと ekikan_t list 型の駅間のリストと直前に確定した駅 p を受け取ったら、
    ダイクストラのアルゴリズムにしたがって各駅について最短距離と最短経路が正しく入った
    リスト (eki_t list 型) を返す *)
(* dijkstra_main : eki_t list -> ekikan_tree_t -> eki_t list *)
let dijkstra_main eki_lst ekikan_tree p =
  (* ここで acc は集合U *) 
  let rec hojo eki_lst ekikan_tree p acc = match eki_lst with
      [] -> acc
    | _::_ -> let updated = koushin p eki_lst ekikan_tree in
        let separated = saitan_wo_bunri updated in
        match separated with
         (q,v_lst) -> hojo v_lst ekikan_tree q (q::acc)
  in hojo eki_lst ekikan_tree p []

(* 目的 : 始点の駅名（ローマ字）と終点の駅名（ローマ字）を受け取ったら、
  各駅までの最短路を確定し、その中から終点の駅のレコードを返す *)
(* dijkstra : string -> string -> ekimei_t *)
let dijkstra shiten_romaji shuten_romaji = 
  let ekimei_list = seiretsu global_ekimei_list in
  let shiten_kanji = romaji_to_kanji shiten_romaji ekimei_list in
  let shuten_kanji = romaji_to_kanji shuten_romaji ekimei_list in
  let initial_eki_list = make_initial_eki_list ekimei_list shiten_kanji in
  let rec eki_search eki_list kanji = match eki_list with
      [] -> failwith "data not found"
    | ({namae=n;saitan_kyori=s;temae_list=t} as first) :: rest -> 
        if n = kanji then first else eki_search rest kanji in
  let shiten = eki_search initial_eki_list shiten_kanji in
  let rec remove lst removed = match lst with
      [] -> failwith "data not found"
    | first :: rest -> if first = removed then rest else first :: remove rest removed in
  let mikakutei_eki_list = remove initial_eki_list shiten in
  let global_ekikan_tree = inserts_ekikan Empty global_ekikan_list in
  let saitan_eki_list = dijkstra_main mikakutei_eki_list global_ekikan_tree shiten in
  let shuten = eki_search saitan_eki_list shuten_kanji in
  shuten


let test = dijkstra "tokyo" "wakousi"