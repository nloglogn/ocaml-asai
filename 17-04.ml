(* 月日を表す型 *)
type year_t = January of int
            | February of int
            | March of int
            | April of int
            | May of int
            | June of int
            | July of int
            | August of int
            | September of int
            | October of int
            | November of int
            | December of int

(* 12星座を表す型 *)
type seiza_t = Aries | Taurus | Gemini | Cancer | Leo | Virgo | Libra | Scorpio | Sagittarius | Capricorn | Aquarius | Pisces

(* 目的 : 月と日を受け取ったら、星座を返す *)
(* seiza : int -> int -> string *)
let seiza year = match year with
    January (d) -> if d < 20 then Capricorn else Aquarius
  | February (d) -> if d < 19 then Aquarius else Pisces
  | March (d) -> if d < 20 then Pisces else Aries
  | April (d) -> if d < 20 then Aries else Taurus
  | May (d) -> if d < 21 then Taurus else Gemini
  | June (d) -> if d < 22 then Gemini else Cancer
  | July (d) -> if d < 23 then Cancer else Leo
  | August (d) -> if d < 23 then Leo else Virgo
  | September (d) -> if d < 23 then Virgo else Libra
  | October (d) -> if d <24 then Libra else Scorpio
  | November (d) -> if d < 23 then Scorpio else Sagittarius
  | December (d) -> if d < 22 then Sagittarius else Capricorn

(* テスト *)
let test01 = seiza (March (21)) = Aries
let test02 = seiza (May (5)) = Taurus
let test03 = seiza (June (9)) = Gemini
let test04 = seiza (July (15)) = Cancer
let test05 = seiza (July (24)) = Leo
let test06 = seiza (September (22)) = Virgo
let test07 = seiza (October (10)) = Libra
let test08 = seiza (November (22)) = Scorpio
let test09 = seiza (December (1)) = Sagittarius
let test10 = seiza (January (1)) = Capricorn
let test11 = seiza (January (28)) = Aquarius
let test12 = seiza (March (3)) = Pisces
