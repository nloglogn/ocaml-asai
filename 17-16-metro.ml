type eki_t = {
  namae : string;
  saitan_kyori : float;
  temae_list : string list
}

(* 目的 : eki_t list 型のリストを受け取ったら、「最短距離最小の駅」と
    「最短距離最小の駅以外からなるリスト」の組を返す *)
(* saitan_wo_bunri : eki_t -> eki_t list -> eki_t * eki_t list *)
let rec saitan_wo_bunri first rest = match rest with
    [] -> (first, [])
  | second :: rest' -> match first with {namae=n1;saitan_kyori=s1;temae_list=t1} ->
      let (p,v) = saitan_wo_bunri second rest' in
        match p with {namae=n2;saitan_kyori=s2;temae_list=t2} ->
            if n1 < n2 then (first,p::v) else (p,first::v)