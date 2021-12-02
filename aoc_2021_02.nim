import os, strutils, sequtils

proc solve1(data:seq[string]): int = 
  var coord: (int, int) # x, y
  for line in data:
    let direction = line.split(" ")[0]
    let distance = line.split(" ")[1].parseInt()

    case direction:
      of "forward":
        coord[0].inc(distance)
      of "down":
        coord[1].inc(distance)
      of "up":
        coord[1].dec(distance)
      else:
        echo "Unrecognized direction!"

  return coord[0] * coord[1]

proc solve2(data:seq[string]): int = 
  var coord: (int, int, int) # x, y, aim
  for line in data:
    let direction = line.split(" ")[0]
    let distance = line.split(" ")[1].parseInt()

    case direction:
      of "forward":
        coord[0].inc(distance)
        coord[1].inc(distance * coord[2])
      of "down":
        coord[2].inc(distance)
      of "up":
        coord[2].dec(distance)
      else:
        echo "Unrecognized direction!"

  return coord[0] * coord[1]

let data = (getAppDir() / "aoc_2021_02.txt").lines.toSeq

echo "Answer Part 1: ", solve1(data)

echo "Answer Part 2: ", solve2(data)