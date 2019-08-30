type ekikan_tree_t = Empty | Node of ekikan_tree_t * string * (string * float) list * ekikan_tree_t

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
