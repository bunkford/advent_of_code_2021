import stats, strutils, algorithm

proc transpose*[T](s: seq[seq[T]]): seq[seq[T]] =
  ## transposes seq of seqs 
  ## transpose(@[@[1, 2], @[3, 4], @[5, 6]]) == @[@[1, 3, 5], @[2, 4, 6]]
  result = newSeq[seq[T]](s[0].len)
  for i in 0 .. s[0].high:
    result[i] = newSeq[T](s.len)
    for j in 0 .. s.high:
      result[i][j] = s[j][i]

proc median*[T](s: seq[T]):int =
  if s.high mod 2 == 1:
    var m1 = s.sorted()[(s.len div 2) - 1]
    var m2 = s.sorted()[(s.len div 2)]
    # because there is no middle value, median is the mean of the two middle values
    result = mean(@[m1, m2]).toInt
  else:
    result = parseFloat($(s.sorted()[(s.len div 2)])).toInt

proc taxi_cab*(a:(int, int), b:(int, int)):int =
  # Takes coordinates and returns taxi cab geometry (shortest route)
  # AKA Manhattan distance or Manhattan length 
  var x1:int = a[0]
  var y1:int = a[1]
  var x2:int = b[0]
  var y2:int = b[1]
  return abs(x2 - x1) + abs(y2 - y1)