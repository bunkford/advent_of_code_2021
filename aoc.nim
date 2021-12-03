proc transpose*[T](s: seq[seq[T]]): seq[seq[T]] =
  ## transposes seq of seqs 
  ## transpose(@[@[1, 2], @[3, 4], @[5, 6]]) == @[@[1, 3, 5], @[2, 4, 6]]
  result = newSeq[seq[T]](s[0].len)
  for i in 0 .. s[0].high:
    result[i] = newSeq[T](s.len)
    for j in 0 .. s.high:
      result[i][j] = s[j][i]


proc taxi_cab*(a:(int, int), b:(int, int)):int =
  # Takes coordinates and returns taxi cab geometry (shortest route)
  # AKA Manhattan distance or Manhattan length 
  var x1:int = a[0]
  var y1:int = a[1]
  var x2:int = b[0]
  var y2:int = b[1]
  return abs(x2 - x1) + abs(y2 - y1)