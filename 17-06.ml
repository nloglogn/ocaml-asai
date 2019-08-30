(* 木を表す型 *)
type tree_t = Empty                         (* 空の木 *)
            | Leaf of int                   (* 葉 *)
            | Node of tree_t * int * tree_t (* 節 *)

(* tree は
       - Empty            空の木、あるいは
       - Leaf (n)         値が n の葉、あるいは
       - Node (t1, n, t2) 左の木がt1, 値がn, 右の木がt2であるような節
                          （t1とt2が自己参照のケース）
    という形 *)

(* 木の例 *)
let tree1 = Empty
let tree2 = Leaf (3)
let tree3 = Node (tree1, 4, tree2)
let tree4 = Node (tree2, 5, tree3)

(* 目的 : int -> int 型の関数 f と tree_t 型の木を受け取ったら、節や葉に入っている値全てにfを適用した木を返す *)
(* tree_map : (int -> int) -> tree_t -> tree_t *)
let tree_map f tree = match tree with
    Empty -> Empty
  | Leaf (n) -> Leaf (f n)
  | Node (t1, n, t2) -> Node (t1, f n, t2)

(* テスト *)
let test1 = tree_map (fun x -> 2 * x) tree1 = Empty
let test2 = tree_map (fun x -> 2 * x) tree2 = Leaf (6)
let test3 = tree_map (fun x -> 2 * x) tree3 = Node (tree1, 8, tree2)
let test4 = tree_map (fun x -> 2 * x) tree4 = Node (tree2, 10, tree3)