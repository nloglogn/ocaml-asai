(* 集合モジュール Set のシグネチャ *)
module type Set_t =
  sig
    type 'a t                           (* 要素の型が 'a の集合の型 *)
    val empty : 'a t                    (* 空集合 *)
    val singleton : 'a -> 'a t          (* 要素ひとつからなる集合 *)
    val union : 'a t -> 'a t -> 'a t    (* 和集合 *)
    val inter : 'a t -> 'a t -> 'a t    (* 共通部分 *)
    val diff : 'a t -> 'a t -> 'a t     (* 差集合 *)
    val mem : 'a -> 'a t -> bool        (* 要素が集合に入っているか *)
  end

(* 集合モジュール Set *)
module Set : Set_t = struct

  type 'a t = 'a list

  let empty = []

  let singleton x = [x]

  let rec mem a x = match x with
      [] -> false
    | first :: rest -> if a = first then true else mem a rest

  let rec union x y = match x with
      [] -> y
    | first :: rest -> if mem first y then union rest y else first :: (union rest y)

  let rec inter x y = match x with
      [] -> []
    | first :: rest -> if mem first y then first :: inter rest y else inter rest y

  let rec diff x y = match x with
      [] -> []
    | first :: rest -> if mem first y then diff rest y else first :: (diff rest y)

end