#use "09-09-metro.ml"

(* 目的 : ekimei_t 型のリストを受け取ったら、それをひらがなの順に整列し、駅の重複を取り除いたリストを返す *)
(* seiretsu : ekimei_t list -> ekimei_t list *)
let seiretsu lst = 
  let rec insert lst ({kanji=c;kana=k;romaji=r;shozoku=s} as eki) = match lst with
      [] -> [eki]
    | ({kanji=c1;kana=k1;romaji=r1;shozoku=s1} as eki1)::rest -> 
        if k1 > k then eki :: lst else eki1 :: insert rest eki
  in let rec eki_sort lst = match lst with
      [] -> []
    | first :: rest -> insert (eki_sort rest) first
  in let sorted_lst = eki_sort lst
  in let rec reduce lst = match lst with
      [] -> []
    | [x] -> [x]
    | ({kanji=c1;kana=k1;romaji=r1;shozoku=s1} as eki1)::({kanji=c2;kana=k2;romaji=r2;shozoku=s2} as eki2)::rest ->
        if k1 = k2 then reduce (eki2 :: rest) else eki1 :: reduce (eki2 :: rest)
  in reduce sorted_lst


(* テスト *)
let lst1 = []
let lst2 = [{kanji="代々木上原"; kana="よよぎうえはら"; romaji="yoyogiuehara"; shozoku="千代田線"}]
let lst3 = [{kanji="代々木上原"; kana="よよぎうえはら"; romaji="yoyogiuehara"; shozoku="千代田線"}; 
            {kanji="代々木公園"; kana="よよぎこうえん"; romaji="yoyogikouen"; shozoku="千代田線"}; 
            {kanji="明治神宮前"; kana="めいじじんぐうまえ"; romaji="meijijinguumae"; shozoku="千代田線"};
            {kanji="明治神宮前"; kana="めいじじんぐうまえ"; romaji="meijijinguumae"; shozoku="千代田線"}]

let test1 = seiretsu lst1 = []
let test2 = seiretsu lst2 = [{kanji="代々木上原"; kana="よよぎうえはら"; romaji="yoyogiuehara"; shozoku="千代田線"}]
let test3 = seiretsu lst3 = [{kanji="明治神宮前"; kana="めいじじんぐうまえ"; romaji="meijijinguumae"; shozoku="千代田線"};
                             {kanji="代々木上原"; kana="よよぎうえはら"; romaji="yoyogiuehara"; shozoku="千代田線"}; 
                             {kanji="代々木公園"; kana="よよぎこうえん"; romaji="yoyogikouen"; shozoku="千代田線"}]