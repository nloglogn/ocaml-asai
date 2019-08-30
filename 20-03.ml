type color_t = Red | Black

type ('a, 'b) rb_tree_t = Empty
                        | Node of ('a, 'b) rb_tree_t * 'a * 'b * color_t * ('a, 'b) rb_tree_t


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




(* テスト *) 
let rb_tree0 = Empty 
let rb_tree1 = insert rb_tree0 10 "x" 
let rb_tree2 = insert rb_tree1 13 "y" 
let rb_tree3 = insert rb_tree2 15 "z" 
 
let test1 = rb_tree1 = Node (Empty, 10, "x", Black, Empty) 
let test2 = rb_tree2 = Node (Empty, 10, "x", Black, 
			     Node (Empty, 13, "y", Red, Empty)) 
let test3 = rb_tree3 = Node (Node (Empty, 10, "x", Black, Empty), 
			     13, "y", Black, 
			     Node (Empty, 15, "z", Black, Empty)) 