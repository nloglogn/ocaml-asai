#use "09-09-metro.ml"

type eki_t = {
  namae : string;
  saitan_kyori : float;
  temae_list : string list
}

(* 目的 : eki_t 型のリストと起点を受け取ったら、指定されたようにeki_tを書き換える *)
(* shokika : eki_t list -> eki_t list *)
let shokika {namae=n; saitan_kyori=s; temae_list=t} kiten = 
    if n = kiten then {namae=n; saitan_kyori=0.0; temae_list=[kiten]}
                 else {namae=n; saitan_kyori=infinity; temae_list=[]}

(* テスト *)
let test1 = shokika {namae="代々木上原"; saitan_kyori=infinity; temae_list=[]} "代々木上原"
          = {namae="代々木上原"; saitan_kyori=0.0; temae_list=["代々木上原"]}
let test2 = shokika {namae="代々木公園"; saitan_kyori=infinity; temae_list=[]} "代々木上原"
          = {namae="代々木公園"; saitan_kyori=infinity; temae_list=[]}
let test3 = shokika {namae="明治神宮前"; saitan_kyori=infinity; temae_list=[]} "代々木上原"
          = {namae="明治神宮前"; saitan_kyori=infinity; temae_list=[]}
