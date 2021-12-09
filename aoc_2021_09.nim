import os, strutils, sequtils, algorithm

proc solve1(data:seq[seq[int]]): int = 
  for y, line in data:
    for x, val in line:
      var up = if y - 1 >= 0: data[y - 1][x] <= val else: false
      var down = if y + 1 <= data.high: data[y + 1][x] <= val else: false
      var left = if x - 1 >= 0: data[y][x - 1] <= val else: false
      var right = if x + 1 <= line.high: data[y][x + 1] <= val else: false

      if up == false and down == false and left == false and right == false:
        result = result + 1 + val
      
proc get_basin_size(data: seq[seq[int]], collected_points: var seq[seq[int]], to_check: seq[int]): int =
  var x = to_check[0]
  var y = to_check[1]
  var up = if @[x, y - 1] notin collected_points and y - 1 >= 0: data[y - 1][x] != 9 else: false
  var down = if @[x, y + 1] notin collected_points and y + 1 <= data.high: data[y + 1][x] != 9 else: false
  var left = if @[x - 1, y] notin collected_points and x - 1 >= 0: data[y][x - 1] != 9 else: false
  var right = if @[x + 1, y] notin collected_points and x + 1 <= data[0].high: data[y][x + 1] != 9 else: false

  if up:
    collected_points.add(@[x, y - 1])
    discard get_basin_size(data, collected_points, @[x, y - 1])
  if down: 
    collected_points.add(@[x, y + 1])
    discard get_basin_size(data, collected_points, @[x, y + 1])
  if left:
    collected_points.add(@[x - 1, y])
    discard get_basin_size(data, collected_points, @[x - 1, y])
  if right:
    collected_points.add(@[x + 1, y])
    discard get_basin_size(data, collected_points, @[x + 1, y])

  if up == false and down == false and left == false and right == false:
    return collected_points.len

proc solve2(data:seq[seq[int]]): int =
  var lowpoints:seq[seq[int]]
  for y, line in data:
    for x, val in line:
      var up = if y - 1 >= 0: data[y - 1][x] <= val else: false
      var down = if y + 1 <= data.high: data[y + 1][x] <= val else: false
      var left = if x - 1 >= 0: data[y][x - 1] <= val else: false
      var right = if x + 1 <= line.high: data[y][x + 1] <= val else: false

      if up == false and down == false and left == false and right == false:
        lowpoints.add(@[@[x, y]])

  var basin_sizes:seq[int]
  for point in low_points:
    var cp:seq[seq[int]] = @[point]
    discard get_basin_size(data, cp, point)
    basin_sizes.add(cp.deduplicate.len)
  
  basin_sizes.sort()
  return basin_sizes[^1] * basin_sizes[^2] * basin_sizes[^3]

let data = (getAppDir() / "aoc_2021_09.txt").lines.toSeq.mapIt(it.toSeq.mapIt(($it).parseInt))

echo "Answer Part 1: ", solve1(data)

echo "Answer Part 2: ", solve2(data)