(* 目的 : x座標とy座標の組で表された平面座標を受け取り、x軸について対称な点の座標を返す *)
(* taisho_x : float * float -> float * float *)
let taisho_x pair = match pair with
  (a,b) -> (a,-. b)

(* テスト *)
let test1 = taisho_x (0.0,0.0) = (0.0,0.0)
let test1 = taisho_x (1.0,1.0) = (1.0,-. 1.0)
let test1 = taisho_x (3.0,-. 2.4) = (3.0,2.4)
