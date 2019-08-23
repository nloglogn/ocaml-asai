(* 目的 : 5教科の点数を与えられたら、その合計点と平均点を組にして返す *)
(* goukei_to_heikin : float -> float -> float -> float -> float -> float * float *)
let goukei_to_heikin kokugo sugaku eigo rika shakai = 
      ((kokugo +. sugaku +. eigo +. rika +. shakai),
      (kokugo +. sugaku +. eigo +. rika +. shakai) /. 5.0)


(* テスト *)
let test1 = goukei_to_heikin 100.0 100.0 100.0 100.0 100.0 = (500.0, 100.0)
let test2 = goukei_to_heikin 40.0 45.0 50.0 55.0 60.0 = (250.0, 50.0)
let test3 = goukei_to_heikin 20.0 100.0 20.0 100.0 10.0 = (250.0, 50.0)
