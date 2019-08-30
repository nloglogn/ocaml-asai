(* 年号を表す型 *)
type nengou_t = Meiji of int    (* 明治 *)
              | Taisho of int   (* 大正 *)
              | Showa of int    (* 昭和 *)
              | Heisei of int   (* 平成 *)
              | Reiwa of int    (* 令和 *)

(* 目的 : 誕生年と現在の年を nengou_t 型の値として受け取り、年齢を返す *)
(* nenrei : nengou_t -> nengou_t -> int *)
let nenrei tanjou genzai =
  let to_seireki nengou = match nengou with
    Meiji (n) -> n + 1867
  | Taisho (n) -> n + 1911
  | Showa (n) -> n + 1925
  | Heisei (n) -> n + 1988
  | Reiwa (n) -> n + 2018
  in
  (to_seireki genzai) - (to_seireki tanjou)


(* テスト *)
let test1 = nenrei (Taisho (8)) (Reiwa (1)) = 100
let test2 = nenrei (Showa (44)) (Reiwa (1)) = 50
let test3 = nenrei (Heisei (11)) (Reiwa (1)) = 20
let test4 = nenrei (Reiwa (1)) (Reiwa (1)) = 0