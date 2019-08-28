(* 目的 : エラトステネスのふるいによって、自然数 n 以下の素数を全て求める *)
(* sieve : int list -> int list *)
let rec sieve lst = match lst with
    [] -> []
  | first :: rest -> let not_divisor m n = n mod m > 0 in
      let next = List.filter (not_divisor first) rest in
      first :: sieve next
  
(* 再帰部分の引数であるnextはrestの部分リストなので、必ず停止する。 *)

(* 目的 : 自然数 n を受け取ったら、n 以下の素数のリストを返す *)
(* prime : int -> int list *)
let prime n = let rec enumerate2 n = if n = 2 then [2] else n :: enumerate2 (n - 1)
  in sieve (List.rev (enumerate2 n))

let test = prime 100