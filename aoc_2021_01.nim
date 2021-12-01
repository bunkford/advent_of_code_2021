import os, strutils

proc solve1(file: string): int = 
  var old:int
  for line in file.lines:
    if line.parseInt() > old:
      inc result
    old = line.parseInt()

proc solve2(file: string): int =
  var data:seq[int]
  for line in file.lines:
    data.add(line.parseInt())

  var old:int
  for k in 0 .. data.len:
    var val:int = data[k + 0] + data[k + 1] + data[k + 2]  
    if val > old:
      inc result
    old = val 

echo "Answer Part 1: ", solve1(getAppDir() / "aoc_2021_01.txt") - 1 # first one doesn't count, so we have to subtract it.

echo "Answer Part 2: ", solve2(getAppDir() / "aoc_2021_01.txt") - 1 # first one doesn't count, so we have to subtract it.