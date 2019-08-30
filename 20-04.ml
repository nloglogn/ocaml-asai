type color_t = Red | Black

type ('a, 'b) rb_tree_t = Empty
                        | Node of ('a, 'b) rb_tree_t * 'a * 'b * color_t * ('a, 'b) rb_tree_t

(* 目的 : 赤黒木とキーを受け取ったら、そのキーに対応する値を赤黒木の中から探してくる *)
(* search : rb_tree_t int -> string *)
let rec search rb_tree key = match rb_tree with
    Empty -> raise Not_found
  | Node (left, key1, value1, color1, right) -> 
      if key = key1 then value1
      else if key < key1 then search left key
      else search right key





(* テスト *) 
let rb_tree = 
  Node (Node (Empty, 10, "x", Black, Empty), 13, "y", Red, 
	Node (Empty, 15, "z", Black, Empty)) 
let test1 = search rb_tree 10 = "x" 
let test2 = search rb_tree 13 = "y" 
let test3 = search rb_tree 15 = "z" 
(* let test4 = search rb_tree 17 *) 
   (* Not_found を起こす *) 
