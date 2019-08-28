type eki_t = {
  namae : string;
  saitan_kyori : float;
  temae_list : string list
}

(* 目的 : eki_t list 型のリストを受け取ったら、「最短距離最小の駅」と
    「最短距離最小の駅以外からなるリスト」の組を返す *)
(* saitan_wo_bunri : eki_t list -> eki_t * eki_t list *)
let saitan_wo_bunri lst = 
  let minimum_kyori lst = List.fold_right (fun {namae=n;saitan_kyori=s;temae_list=t} rest_result -> 
        if s < rest_result then s else rest_result) lst max_float in
  let min_lst = minimum_kyori lst in
  let rec argmin lst min_value = List.fold_right (fun ({namae=n;saitan_kyori=s;temae_list=t} as p) rest_result ->
            if s = min_value then p else rest_result) lst {namae="";saitan_kyori=max_float;temae_list=[]} in
  let removed = argmin lst min_lst in
  let remove lst removed = List.fold_right (fun first rest_result -> if first = removed then rest_result else first :: rest_result) lst [] in
      (removed, remove lst removed)

let eki1 = {namae="a";saitan_kyori=0.5;temae_list=[]}
let eki2 = {namae="b";saitan_kyori=0.7;temae_list=[]}
let eki3 = {namae="c";saitan_kyori=0.3;temae_list=[]}
let eki4 = {namae="d";saitan_kyori=1.2;temae_list=[]}

let lst1 = [eki1]
let lst2 = [eki1;eki2]
let lst3 = [eki1;eki2;eki3]
let lst4 = [eki1;eki2;eki3;eki4]

let test1 = saitan_wo_bunri lst1
let test2 = saitan_wo_bunri lst2
let test3 = saitan_wo_bunri lst3
let test4 = saitan_wo_bunri lst4