(* 多相の木を表す型 *)
type 'a tree_t = Empty                              (* 空の木 *)
               | Leaf of 'a                         (* 葉 *)
               | Node of 'a tree_t * 'a * 'a tree_t (* 節 *)
               
(* 木の例 *)
let tree1 = Empty
let tree2 = Leaf (3)
let tree3 = Node (tree1, 4, tree2)
let tree4 = Node (tree2, 5, tree3)

(* 目的 : tree に含まれる整数を全て加える *)
(* sum_tree : tree_t -> int *)
let rec sum_tree tree = match tree with
    Empty -> 0
  | Leaf(n) -> n
  | Node (t1, n, t2) -> sum_tree t1 + n + sum_tree t2

(* テスト *)
let test1 = sum_tree tree1 = 0
let test2 = sum_tree tree2 = 3
let test3 = sum_tree tree3 = 7
let test4 = sum_tree tree4 = 15

(* 型は int tree_t -> int である。
木の要素は、例えば演算子+の引数でなければならないことから int 型に決定される *)