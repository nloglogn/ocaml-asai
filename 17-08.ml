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

(* 目的 : tree_t 型の木を受け取ったら、木の深さを返す *)
(* tree_depth : tree_t -> int *)
let rec tree_depth tree = match tree with
    Empty -> 0
  | Leaf (n) -> 1
  | Node(t1, n, t2) -> 1 + max (tree_depth t1) (tree_depth t2)

(* テスト *)
let test1 = tree_depth tree1 = 0
let test2 = tree_depth tree2 = 1
let test3 = tree_depth tree3 = 2
let test4 = tree_depth tree4 = 3