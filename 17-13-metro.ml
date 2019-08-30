#use "09-10-metro.ml"

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