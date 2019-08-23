type book_t = {
  title : string;       (* タイトル *)
  author : string;      (* 著者 *)
  publisher : string;   (* 出版社 *)
  price : int;       (* 値段 *)
  isbn : string;        (* ISBN *) 
}

let book1 = {
  title = "プログラミングの基礎";
  author = "浅井健一";
  publisher = "サイエンス社";
  price = 2300;
  isbn = "978-4-7819-1160-1"
}
let book2 = {
  title = "英文解体新書";
  author = "北村一真";
  publisher = "研究者";
  price = 2200;
  isbn = "978-4-327-45292-6"
}
let book3 = {
  title = "線形代数学（新装版）";
  author = "佐武一郎";
  publisher = "裳華房";
  price = 3400;
  isbn = "978-4-7853-1316-6"
}