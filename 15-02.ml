(* 目的 : ふたつの自然数 m と n の最大公約数を、ユークリッドの互除法で求める *)
(* gcd : int -> int -> int *)
let rec gcd m n = 
  if n = 0 then m
  else gcd n (m mod n)

(* gcdの第2引数はnで割ったあまりなので0とn-1の間の自然数である。
よって、有限回で0に到達する *)

(* テスト *)
let test1 = gcd 3 0 = 3
let test2 = gcd 3 2 = 1
let test3 = gcd 9 3 = 3
let test4 = gcd 27 6 = 3