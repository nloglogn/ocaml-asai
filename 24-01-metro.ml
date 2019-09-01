(* 最短経路の表示において、経由する路線も表示するように変更 *)

#use "09-09-metro.ml"
#use "09-10-metro.ml"

type eki_t = {
  namae : string;
  saitan_kyori : float;
  temae_list : string list
}

(* 赤黒木を表すモジュールのシグネチャ *)
module type Tree_t = sig
  type ('a, 'b) t
  
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

    val traverse : ('a -> 'b -> 'c -> 'a) -> 'a -> ('b, 'c) t -> 'a 
    val length : ('a, 'b) t -> int 
end

(* 赤黒木を表すモジュール *)
module RedBlack : Tree_t = struct

  (* 赤か黒かを示す型 *)
  type color_t = Red | Black
  
  (* 2分探索木を表す型 *)
  type ('a, 'b) t = Empty
                  | Node of ('a, 'b) t * 'a * 'b * color_t * ('a, 'b) t
  
  (* 空の木 *)
  let empty = Empty

(* 目的 : rb_tree_t型の木を受け取ったらその木が図20.2のようになっているか調べ、
    そうなっていたら図の右側の木を返す *)
(* balance : rb_tree_t -> rb_tree_t *)
let balance rb_tree = match rb_tree with
    Node(Node(Node(a,x1,x2,Red,b),y1,y2,Red,c),z1,z2,Black,d)
  | Node(Node(a,x1,x2,Red,Node(b,y1,y2,Red,c)),z1,z2,Black,d)
  | Node(a,x1,x2,Black,Node(Node(b,y1,y2,Red,c),z1,z2,Red,d))
  | Node(a,x1,x2,Black,Node(b,y1,y2,Red,Node(c,z1,z2,Red,d)))
      -> Node(Node(a,x1,x2,Black,b),y1,y2,Red,Node(c,z1,z2,Black,d))
  | _ -> rb_tree

(* 目的 : 赤黒木とキーと値を受け取ったら、それを挿入した赤黒木を返す *)
(* insert : rb_tree_t -> int -> string -> rb_tree_t *)
let insert rb_tree key value = 
    let rec insert1 rb_tree = match rb_tree with
        Empty -> Node(Empty, key, value , Red, Empty)
      | Node(left, key_x, value_x, color_x, right) ->
          if key < key_x then balance (Node(insert1 left,key_x, value_x, color_x, right))
          else if key > key_x then balance (Node(left, key_x, value_x, color_x, insert1 right))
          else Node(left, key, value, color_x, right)
    in let inserted = insert1 rb_tree
    in match inserted with
        Empty -> assert false
      | Node(left, key, value, color, right) -> Node(left, key, value, Black, right)
      
(* 目的 : 赤黒木とキーを受け取ったら、そのキーに対応する値を赤黒木の中から探してくる *)
(* search : rb_tree_t int -> string *)
let rec search rb_tree key = match rb_tree with
Empty -> raise Not_found
| Node (left, key1, value1, color1, right) -> 
  if key = key1 then value1
  else if key < key1 then search left key
  else search right key

  let rec traverse f init tree = match tree with 
    Empty -> init 
  | Node (left, key, value, _, right) -> 
    let result1 = f init key value in 
    let result2 = traverse f result1 left in 
    let result3 = traverse f result2 right in 
      result3

let rec length tree = match tree with 
    Empty -> 0 
  | Node (left, key, value, _, right) -> 
         length left + 1 + length right 

end

(* ヒープのシグネチャ *)
module type Heap_t =
sig
  type ('a, 'b) t
  (* 最小値を求める値が 'a 型でその他の付加情報が 'b 型であるヒープの型 *)

  type index_t
  (* ヒープの添字の型 *)

  val create : int -> 'a -> 'b -> ('a , 'b) t
  (* 使い方 : create size key value *)
  (* ヒープのサイズと'a型と'b型のダミーの値を受け取ったら *)
  (* 空のヒープを返す *)

  val insert : ('a, 'b) t -> 'a -> 'b -> index_t * ('a, 'b) t
  (* 使い方 : insert heap key value *)
  (* ヒープには新しい要素を追加する *)
  (* ヒープは（破壊的に）書き換わる *)

  val get : ('a, 'b) t -> index_t -> 'a * 'b
  (* 使い方 : get heap index *)
  (* ヒープの index 番目の要素を返す *)

  val set : ('a, 'b) t -> index_t -> 'a -> 'b -> ('a, 'b) t
  (* 使い方 : set heap index key value *)
  (* ヒープの index 番目の値を更新したヒープを返す *)
  (* ヒープは（破壊的に）書き換わる *)

  val split_top : ('a, 'b) t -> ('a * 'b) * ('a, 'b) t
  (* 使い方 : split_top heap *)
  (* 最小の値を持つものとそれを取り除いたヒープの組を返す *)
  (* ヒープは（破壊的に）書き換わる *)

  val length : ('a, 'b) t -> int
  (* ヒープの要素数を返す *)

  val show : ('a, 'b) t -> unit
  (* デバッグ用 : ヒープを表す配列を表示する *)

end

module Heap =
struct

  type index_t = int ref

  type ('a, 'b) t = int ref * (index_t * 'a * 'b) array (* int ref はヒープの長さを表す *)

  let swap arr ind1 ind2 =
    let ((index1,key1,value1) as p) = arr.(ind1) in
    let ((index2,key2,value2) as q) = arr.(ind2) in
      arr.(ind1) <- q;
      arr.(ind2) <- p;
      index1 := ind2;
      index2 := ind1

  let rec update_up arr ind = (* ind は参照ではない *)
    if ind = 0 then () else
      match arr.(ind) with (_,k,_) ->
      match arr.((ind - 1)/2) with (_,l,_) ->
        if (ind >= 0 && k < l) then
        begin
          swap arr ind ((ind - 1)/2);
          update_up arr ((ind - 1)/2)
        end
    else ()

  let rec update_down len_val arr ind  = (* ind, len_val は参照ではない *)
    let (ind0, k0, v0) = arr.(ind) in
    if 2 * ind + 1 >= len_val then ()
    else let (ind1, k1, v1) = arr.(2 * ind + 1) in
        if 2 * ind + 2 >= len_val then
          if k0 > k1 then
          begin
            swap arr ind (2 * ind + 1);
            update_down len_val arr (2 * ind + 1)
          end 
          else ()
        else let (ind2, k2, v2) = arr.(2 * ind + 2) in
          if (k0 > k1 || k0 > k2)
            then if k1 < k2
                then begin 
                      swap arr ind (2 * ind + 1);
                      update_down len_val arr (2 * ind + 1)
                     end
                else begin
                       swap arr ind (2 * ind + 2); 
                       update_down len_val arr (2 * ind + 2)
                     end
            else ()

  let create size key value = (ref (0), Array.make size (ref (-1), key, value))

  let insert (len, arr) key value =
    let len1 = ref !len in
    arr.(!len) <- (len1, key, value);
    update_up arr !len;
    len := !len + 1;
    (len1,(len,arr))
  
  let get (len,array) index = 
    if 0 <= !index && !index <= !len
    then let (i,k,v) = array.(!index) in
      (k,v)
    else raise Not_found

  let set (len, arr) index key value =
    arr.(!index) <- (index, key, value);
    match arr.((!index - 1)/2) with (i,k,v) ->
    if key < k then
      update_up arr !index
    else update_down !len arr !index;
    (len,arr)

  let split_top (len,arr) = 
    let (i,k,v) = arr.(0)
    in len := !len - 1;
      arr.(0) <- arr.(!len);
      update_down !len arr 0;
      i := -1;
      ((k,v),(len,arr)) 

  let length heap = !(fst heap)

end

open RedBlack

(* 目的 : string * (string * float) list) RedBlack.t 型の木と ekikan_t 型の駅間を受け取り、その情報を挿入した木を返す *)
(* insert_ekikan : string * (string * float) list) RedBlack.t -> ekikan_t -> string * (string * float) list) RedBlack.t *)
let insert_ekikan tree {kiten=k;shuten=s;keiyu=v;kyori=d;jikan=t} = 
    let rec insert1 tree eki1 eki2 kyori =
      let lst = try
         search tree eki1 
      with Not_found -> [] in
        insert tree eki1 ((eki2,kyori)::lst)
    in let inserted_half = insert1 tree k s d
    in insert1 inserted_half s k d

(* 目的 : string * (string * float) list) RedBlack.t 型の木と ekikan_t list 型の駅間リストを受け取り、リストの中に含まれる駅間を
          すべて挿入した木を返す *)
(* inserts_ekikan : string * (string * float) list) RedBlack.t -> ekikan_t list -> string * (string * float) list) RedBlack.t *)
let inserts_ekikan tree ekikan_list = List.fold_left insert_ekikan tree ekikan_list

(* 目的 : 重複を取り除き、各店の接続情報を表す木 ekikan_tree を作る。 *)
(* make_ekikan_tree : ekikan_t list -> ekikan_tree_t *)
let make_ekikan_tree ekikan_list = inserts_ekikan empty ekikan_list

(* 未確定駅を表すヒープの型。以下heap_tと記述 *)
(* type heap_t = (float,          最短距離
                  string *        駅名 
                  string list *   手前リスト
                  ) Heap.t *)
(* 各駅のヒープ中の位置を表す木の型。以下 index_tree_t と記述 *)
(* type index_tree_t = (string, index_t) RedBlack.t *)

(* 目的 : ekimei_t 型のリストを受け取ったら、それをひらがなの順に整列し、駅の重複を取り除いたリストを返す *)
(* seiretsu : ekimei_t list -> ekimei_t list *)
let seiretsu lst = 
  let rec insert1 lst ({kanji=c;kana=k;romaji=r;shozoku=s} as eki) = match lst with
      [] -> [eki]
    | ({kanji=c1;kana=k1;romaji=r1;shozoku=s1} as eki1)::rest -> 
        if k1 > k then eki :: lst else eki1 :: insert1 rest eki
  in let rec eki_sort lst = match lst with
      [] -> []
    | first :: rest -> insert1 (eki_sort rest) first
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

(* 目的 : ekikan_list から eki_heap と index_tree を作り、kiten を初期化する *)
(* make_eki_heap_and_index_tree : 
  string -> ekikan_t list -> heap_t * index_tree_t *)
let make_eki_heap_and_index_tree kiten ekikan_tree =
  traverse (fun (eki_heap, index_tree) k lst ->
    let (index, heap) = Heap.insert eki_heap
      (if k = kiten then 0.0 else infinity)
      (k, if k = kiten then [k] else []) in
      let index_tree' = insert index_tree k index in
      (heap, index_tree'))
      ((Heap.create (length ekikan_tree) 0.0 ("駅名", [])),
      empty)
      ekikan_tree  

(* 目的 : 確定した駅に接続している駅の最短距離、手前リストを更新する *)
(* koushin : string -> float -> string list -> heap_t -> ekikan_tree_t -> index_tree_t -> heap_t *)
let koushin pn ps pt eki_heap ekikan_tree index_tree =
  let lst = search ekikan_tree pn in
  List.fold_left (fun eki_heap (shuten, kyori) -> try
    let shuten_index = search index_tree shuten in
    let (saitan_kyori, (n, _)) =
      Heap.get eki_heap shuten_index in
      let new_saitan_kyori = ps +. kyori in
      if new_saitan_kyori <= saitan_kyori
      then Heap.set eki_heap shuten_index
        new_saitan_kyori (n, (n :: pt))
      else eki_heap
    with Not_found -> eki_heap)
  eki_heap
  lst

(* 目的 : 未確定駅のリストと駅間リストから、各駅への最短経路を求める *)
(* dijkstra_main : heap_t -> ekikan_tree_t -> index_tree_t -> eki_t list *)
let rec dijkstra_main eki_heap ekikan_tree index_tree = 
  if Heap.length eki_heap = 0
  then []
  else let ((ps, (pn, pt)), rest_heap) = Heap.split_top eki_heap in
    let eki_heap2 = koushin pn ps pt rest_heap ekikan_tree index_tree in
      {namae=pn; saitan_kyori=ps; temae_list=pt}
      :: dijkstra_main eki_heap2 ekikan_tree index_tree

let rec search_keiyu temae ekikan_list = 
  let rec search_ekikan x y ekikan_list = match ekikan_list with
        [] -> raise Not_found
      | first :: rest ->
    let {kiten=k;shuten=s;keiyu=v;kyori=d;jikan=t} = first in
    if (k = x && s = y) || (k = y && s = x) then v
    else search_ekikan x y rest
  in
  let rec sear temae ekikan_list acc = match temae with
    [] -> raise Not_found
  | [x] -> acc
  | x :: y :: rest -> 
      let v = search_ekikan x y ekikan_list in
      sear (y :: rest) ekikan_list (v :: acc)
  in 
  sear temae ekikan_list []

(* 目的 : eki_t 型のレコードを受け取ったら、それをきれいな形に出力する *)
(* print_eki : eki_t -> unit *)
let print_eki eki = 
  let sen = search_keiyu eki.temae_list global_ekikan_list in
  let print1 eki = match eki with {namae=n;saitan_kyori=s;temae_list=t} ->
    (print_string n;
     print_string "駅までの最短距離は";
     print_float s;
     print_string "kmで、最短経路は\n")
  in let rec print2 temae sen = match temae with
      [] -> failwith "経路がありません"
    | [x] -> (print_string x; print_string "\nです。\n")
    | x::y::rest -> match sen with
      [] -> raise Not_found
    | v::rest' -> 
    (print_string x; print_string " <-(";print_string v;print_string ")- "; print2 (y::rest) rest')
  in match eki with {namae=n;saitan_kyori=s;temae_list=t} ->
      (print1 eki; print2 t sen)

(* 目的 : 始点の駅名（ローマ字）と終点の駅名（ローマ字）を受け取ったら、
  各駅までの最短路を確定し、その中から終点の駅のレコードを返す *)
(* dijkstra : string -> string -> ekimei_t *)
let dijkstra shiten_romaji shuten_romaji = 
  let ekimei_list = seiretsu global_ekimei_list in
  let shiten_kanji = romaji_to_kanji shiten_romaji ekimei_list in
  let shuten_kanji = romaji_to_kanji shuten_romaji ekimei_list in
  let ekikan_tree = make_ekikan_tree global_ekikan_list in
  let (eki_heap, index_tree) =
      make_eki_heap_and_index_tree shiten_kanji ekikan_tree in
  let eki_list = dijkstra_main eki_heap ekikan_tree index_tree in
  let rec eki_search eki_list kanji = match eki_list with
      [] -> {namae=""; saitan_kyori=infinity; temae_list=[]}
    | ({namae=n;saitan_kyori=s;temae_list=t} as first) :: rest -> 
        if n = kanji then first else eki_search rest kanji in
  let shuten = eki_search eki_list shuten_kanji in
  print_eki shuten



let test = dijkstra "toyosu" "wakousi"

