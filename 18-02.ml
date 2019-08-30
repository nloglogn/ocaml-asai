(* 目的 : 野菜のリストと八百屋のリストを受け取ったら、野菜のリストのうち八百屋においていない
          野菜の数を返す *)
(* count_urikire_yasai : string list -> (string * int) list -> int *)
let rec count_urikire_yasai yasai_list yaoya_list =
  let rec search_yasai yasai yaoya_list = match yaoya_list with
      [] -> None
    | first :: rest -> let (y,p) = first in
        if yasai = y then Some (y) else search_yasai yasai rest
    in match yasai_list with
        [] -> 0
      | first :: rest -> match search_yasai first yaoya_list with
          None -> 1 + count_urikire_yasai rest yaoya_list
        | Some (y) -> count_urikire_yasai rest yaoya_list


(* 八百屋においてある野菜と値段のリストの例 *)
let yaoya_list = [("トマト", 300); ("たまねぎ", 200);
                    ("にんじん", 150); ("ほうれん草",200)]
(* テスト *)
let test1 = count_urikire_yasai [] yaoya_list = 0
let test2 = count_urikire_yasai ["トマト";"にんじん"] yaoya_list = 0
let test3 = count_urikire_yasai ["たまねぎ";"じゃがいも"] yaoya_list = 1