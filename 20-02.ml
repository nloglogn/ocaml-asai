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



(* テスト *) 
let rb_tree1 = 
  Node (Node (Node (Empty, 10, "x", Red, Empty), 13, "y", Red, Empty), 
	15, "z", Black, Empty) 
let rb_tree2 = 
  Node (Node (Empty, 10, "x", Red, Node (Empty, 13, "y", Red, Empty)), 
	15, "z", Black, Empty) 
let rb_tree3 = 
  Node (Empty, 10, "x", Black, 
	Node (Node (Empty, 13, "y", Red, Empty), 15, "z", Red, Empty)) 
let rb_tree4 = 
  Node (Empty, 10, "x", Black, 
	Node (Empty, 13, "y", Red, Node (Empty, 15, "z", Red, Empty))) 
let rb_tree5 = 
  Node (Node (Empty, 10, "x", Black, Empty), 13, "y", Red, 
	Node (Empty, 15, "z", Black, Empty)) 
let rb_tree6 = Empty 
let test1 = balance rb_tree1 = rb_tree5 
let test2 = balance rb_tree2 = rb_tree5 
let test3 = balance rb_tree3 = rb_tree5 
let test4 = balance rb_tree4 = rb_tree5 
let test5 = balance rb_tree6 = rb_tree6 

(* テスト例は、著者の用意した回答例から拝借しました。以降も同様です *)