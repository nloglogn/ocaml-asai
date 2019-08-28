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

(* 練習問題 14-01 *)
(* 目的 : 整数のリストを受け取ったら、その中の偶数の要素のみを含むリストを返す *)
(* even : int list -> int list *)
let even lst = let is_even n = n mod 2 = 0
  in List.filter is_even lst

(* テスト *)
let test1 = even [] = []
let test2 = even [2] = [2]
let test3 = even [1;3] = []
let test4 = even [1;2;3;4;5;6;7;8;9;0] = [2;4;6;8;0]


(* 練習問題 14-02 *)
(* 目的 : 学生リスト lst のうち成績が A の人の数を返す *)
(* count_A : gakusei_t list -> int *)
let count_A lst = let is_A {namae=nl;tensuu=t;seiseki=s} = s = "A"
  in  List.length (List.filter is_A lst)

(* テスト *)
let test5 = count_A lst1 = 0
let test6 = count_A lst2 = 0
let test7 = count_A lst3 = 1
let test8 = count_A lst4 = 2


(* 練習問題 14-03 *)
(* 目的 : 文字列のリストを受け取ったら、その中の要素をくっつけた文字列を返す *)
(* concat : string list -> string *)
let concat lst = let conc_string first rest_result = first ^ rest_result
  in List.fold_right conc_string lst ""

(* テスト *)
let test9 = concat [] = ""
let test10 = concat ["2"] = "2"
let test11 = concat ["春";"夏";"秋";"冬"] = "春夏秋冬"


(* 練習問題 14-04 *)
(* 目的 : gakusei_t 型のリストを受け取ったら、全員の得点の合計を返す *)
(* gakusei_sum : gakusei_t list -> int *)
let gakusei_sum lst = 
  let add_tensuu {namae=n;tensuu=t;seiseki=s} rest_result = t + rest_result
  in List.fold_right add_tensuu lst 0

(* テスト *)
let test12 = gakusei_sum lst1 = 0
let test13 = gakusei_sum lst2 = 70
let test14 = gakusei_sum lst3 = 155
let test15 = gakusei_sum lst4 = 235
