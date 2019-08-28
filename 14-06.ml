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

(* 目的 : 学生リスト let のうち成績が seiseki0 の人の数を返す *)
(* count : gakusei_t list -> string -> list *)
let count lst seiseki0 = let is_seiseki0 {namae=nl;tensuu=t;seiseki=s} = s = seiseki0
  in List.length (List.filter is_seiseki0 lst )

(* 目的 : 学生リスト lst のうち成績が A の人の数を返す *)
(* count_A : gakusei_t list -> int *)
let count_A lst = count lst "A"

(* テスト *)
let test1 = count_A lst1 = 0
let test2 = count_A lst2 = 0
let test3 = count_A lst3 = 1
let test4 = count_A lst4 = 2