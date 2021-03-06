import os, strutils, sequtils

proc get_neighbours(y:int, x:int): array[0..7, array[0..1, int]] =
  return [[y - 1, x - 1], [y - 1, x], [y - 1, x + 1],
          [y, x - 1], [y, x + 1],
          [y + 1, x - 1], [y + 1, x],  [y + 1, x + 1]]

proc flash(data: var seq[seq[int]]): int =
  for y, line in data:
    for x, val in line:
      if data[y][x] > 9:
        result.inc
        data[y][x] = 0
        var neighbours = get_neighbours(y, x)
        for coords in neighbours:
          if coords[0] <= data.high and coords[0] >= 0 and coords[1] <= line.high and coords[1] >= 0:
            if data[coords[0]][coords[1]] != 0:
              data[coords[0]][coords[1]].inc
            if data[coords[0]][coords[1]] > 9:
              result.inc flash(data)

proc solve1(data: seq[seq[int]], steps: int): int =
  var d = data
  for step in 1 .. steps:
    for y, line in d:
      for x, val in line:
        d[y][x].inc
    result.inc flash(d)

proc solve2(data: seq[seq[int]]): int =
  var d = data
  while d != repeat(repeat(0, 10), 10):
    result.inc
    for y, line in d:
      for x, val in line:
        d[y][x].inc
    discard flash(d)

var data = (getAppDir() / "aoc_2021_11.txt").lines.toSeq.mapIt(it.toSeq.mapIt(($it).parseInt))

echo "Answer Part 1: ", solve1(data, 100) 
echo "Answer Part 2: ", solve2(data) 
