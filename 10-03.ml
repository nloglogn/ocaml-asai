(* 学生一人分のデータを表す型 *)
type gakuset_t = {
  namae : string;   (* 名前 *)
  tensuu : int;     (* 点数 *)
  seiseki : string; (* 成績 *)
}

(* gakusei_t list は
    - []                空リスト、あるいは
    - first :: rest )   最初の要素が firstで残りのリストがrest
                        (first は gakusei_t 型
                        rest が自己参照のケース 
  という形。 *)

  (* galisei_t list 型のデータの例 *)
let lst1 = []
let lst2 = [{namae = "asai"; tensuu = 70; seiseki = "B"}]
let lst3 = [{namae = "asai"; tensuu = 70; seiseki = "B"};
            {namae = "kaneko"; tensuu = 85; seiseki = "A"}]
let lst4 = [{namae = "yoshida"; tensuu = 80; seiseki = "A"};
            {namae = "asai"; tensuu = 70; seiseki = "B"};
            {namae = "kaneko"; tensuu = 85; seiseki = "A"}]

(* 目的 : gakusei_t型の昇順のリストとgakusei_t型のデータを受け取ったら、それを挿入した昇順のリストを返す *)
(* gakusei_insert : gakusei_t list -> galiset_t -> gakusei_t list *)
let rec gakusei_insert lst gakusei = match lst with
    [] -> [gakusei]
  | ({namae = n; tensuu = t; seiseki = s} as x)::rest -> 
          (match gakusei with
          {namae = n2; tensuu = t2; seiseki = s2} ->
            if t < t2 then x :: gakusei_insert rest gakusei else gakusei :: lst)

(* 目的 : gakusei_t型のリストを受け取ったら、点数の順に整列したリストを返す *)
(* gakusei_sort : gakusei_t list -> gakusei_t list *)
let rec gakusei_sort lst = match lst with
    [] -> []
  | x::rest -> gakusei_insert (gakusei_sort rest) x 


(* テスト *)
let test9 = gakusei_sort lst1 = []
let test10 = gakusei_sort lst2 = [{namae = "asai"; tensuu = 70; seiseki = "B"}]
let test11 = gakusei_sort lst3 = [{namae = "asai"; tensuu = 70; seiseki = "B"};
                                  {namae = "kaneko"; tensuu = 85; seiseki = "A"}]
let test12 = gakusei_sort lst4 = [{namae = "asai"; tensuu = 70; seiseki = "B"};
                                  {namae = "yoshida"; tensuu = 80; seiseki = "A"};
                                  {namae = "kaneko"; tensuu = 85; seiseki = "A"}]
