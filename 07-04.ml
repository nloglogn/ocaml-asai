(* 目的 : x座標とy座標の組で表された平面座標を2つ受け取り、その中点の座標を返す *)
(* chuten : float * float -> float * float -> float * float *)
let chuten pt1 pt2 = match pt1 with
    (x1,y1) -> match pt2 with
    (x2,y2) -> ((x1 +. x2) /. 2.0, (y1 +. y2) /. 2.0)


(* テスト *)
let test1 = chuten (0.0,0.0) (0.0,0.0) = (0.0,0.0)
let test2 = chuten (0.0,0.0) (1.0,1.0) = (0.5,0.5)
let test3 = chuten (-. 1.0,-. 2.0) (2.0,1.0) = (0.5,-. 0.5)