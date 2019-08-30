#use "09-10-metro.ml"

(* 2分探索木を表すモジュール *)
module Tree = struct
  (* 2分探索木を表す型 *)
  type ('a, 'b) t = Empty
                  | Node of ('a, 'b) t * 'a * 'b * ('a, 'b) t
  
  (* 空の木 *)
  let empty = Empty

  (* 目的 : tree にキーが k で値が v を挿入した木を返す *)
  (* insert : ('a, 'b) t -> 'a -> 'b -> ('a, 'b) t *)
  let rec insert tree k v = match tree with
      Empty -> Node (Empty, k, v, Empty)
    | Node (left, key, value, right) ->
        if k = key then Node (left, key, v, right)
        else if k < key
             then Node (insert left k v, key, value, right)
             else Node (left, key, value, insert right k v)
  (* 目的 : tree の中のキー k に対応する値を探して返す *)
  (* みつからなければ例外 Not_found を起こす*)
  (* search : ('a, 'b) t -> 'a -> 'b *)
  let rec search tree k = match tree with
      Empty -> raise Not_found
    | Node (left, key, value, right) -> 
        if k = key then value
        else if k < key then search left k
                        else search right k
end

(* 2分探索木を表すモジュールのシグネチャ *)
module type Tree_t = sig
  type ('a, 'b) t
    (* キーが 'a 型, 値が 'b 型の木の型。型の中身は非公開 *)
  
  val empty : (' a, 'b) t
    (* 使い方 : empty *)
    (* 空の木 *)
  
  val insert : ('a, 'b) t -> 'a -> 'b -> ('a, 'b) t
    (* 使い方 : insert tree key value *)
    (* 木 tree にキー key と値 value を挿入した木を返す *)
    (* キーがすでに存在したら新しい値に置き換える *)

  val search : ('a, 'b) t -> 'a -> 'b
    (* 使い方 : search tree key *)
    (* 木 tree の中からキー key に対応する値を探して返す *)
    (* みつからなければ Not_found を raise する *)
end

(* 目的 : 漢字の駅名2つと string * (string * float) list) Tree.t 型の木を受け取り、その2駅間の距離を返す *)
(* get_ekikan_kyori : string -> string -> (string * (string * float) list) Tree.t) -> float *)
let get_ekikan_kyori ekimei1 ekimei2 ekikan_tree = 
  try List.assoc ekimei2 (Tree.search ekikan_tree ekimei1)
  with Not_found -> infinity

(* 目的 : string * (string * float) list) Tree.t 型の木と ekikan_t 型の駅間を受け取り、その情報を挿入した木を返す *)
(* insert_ekikan : string * (string * float) list) Tree.t -> ekikan_t -> string * (string * float) list) Tree.t *)
let insert_ekikan tree {kiten=k;shuten=s;keiyu=v;kyori=d;jikan=t} = 
    let rec insert tree eki1 eki2 kyori =
      let lst = try
         Tree.search tree eki1 
      with Not_found -> [] in
        Tree.insert tree eki1 ((eki2,kyori)::lst)
    in let inserted_half = insert tree k s d
    in insert inserted_half s k d

    (* 目的 : string * (string * float) list) Tree.t 型の木と ekikan_t list 型の駅間リストを受け取り、リストの中に含まれる駅間を
          すべて挿入した木を返す *)
(* inserts_ekikan : string * (string * float) list) Tree.t -> ekikan_t list -> ekika_tree_t *)
let inserts_ekikan tree ekikan_list = List.fold_left insert_ekikan tree ekikan_list


    (* テスト *) 
let global_ekikan_tree = inserts_ekikan Tree.empty global_ekikan_list 
let test1 = get_ekikan_kyori "茗荷谷" "新大塚" global_ekikan_tree = 1.2 
(* let test2 = get_ekikan_kyori "茗荷谷" "池袋" global_ekikan_tree *) 
   (* Not_found を起こす *) 
let test3 = get_ekikan_kyori "東京" "大手町" global_ekikan_tree = 0.6