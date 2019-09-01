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