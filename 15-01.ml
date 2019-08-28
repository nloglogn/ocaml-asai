(* 目的 : 受け取った lst をクイックソートを使って昇順に整列する *)
(* quick_sort : int list -> int list *)
let rec quick_sort lst = 
  (* 目的: lstの中から n より p である要素のみを取り出す *)
(* take : int -> int list -> (int -> int -> bool) -> int list *)
let take n lst p = List.filter (fun item -> p item n) lst
in
(* 目的 : lst の中から n より小さい要素のみを取り出す *)
(* take_less : int -> int_list -> int list *)
let take_less n lst = take n lst (<)
in
(* 目的 : lst の中から n より大きい要素のみを取り出す *)
(* take_greater : int -> int_list -> int list *)
let take_greater n lst = take n lst (>=)
in
  match lst with
    [] -> [] (* 自明に答えが出るケース *)
  | first :: rest -> (* それ以外のケース *)
      quick_sort (take_less first rest)
      @ [first]
      @ quick_sort (take_greater first rest)


(* テスト *)
let test1 = quick_sort [] = []
let test2 = quick_sort [1] = [1]
let test3 = quick_sort [1;2] = [1;2]
let test4 = quick_sort [2;1] = [1;2]
let test5 = quick_sort [5;4;9;5;2;3] = [2;3;4;5;5;9]
(* test5のように、要素に重複がある場合に正しい結果を返さない。重複している要素が基準に選ばれた時に
重複ぶんはtake_lessでもtake_greaterでも選ばれないからである。
解決するには、take_lessかtake_greaterのうち一方に=をつければよい。 *)
