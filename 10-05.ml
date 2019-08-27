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

(* 目的 : gakusei_t 型のデータを受け取ったら、得点を返す *)
(* gakusei_tensuu : gakusei_t -> int *)
let gakusei_tensuu gakusei = match gakusei with
    {namae = n; tensuu = t; seiseki = s} -> t

(* 目的 : gakusei_t型のリストを受け取ったら、その中から最高得点を取った人のレコードを返す *)
(* gakusei_max : gakusei_t list -> gakusei_t *)
let rec gakusei_max lst = match lst with
    [] -> { namae = ""; tensuu= -1; seiseki = ""}
  | ({namae = n; tensuu = t; seiseki = s} as x)::rest -> 
      if t >= gakusei_tensuu (gakusei_max rest) then x
      else gakusei_max rest


(* テスト *)
let test1 = gakusei_max lst2 = {namae = "asai"; tensuu = 70; seiseki = "B"}
let test2 = gakusei_max lst3 = {namae = "kaneko"; tensuu = 85; seiseki = "A"}
let test3 = gakusei_max lst4 = {namae = "kaneko"; tensuu = 85; seiseki = "A"}