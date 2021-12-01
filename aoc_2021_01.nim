import os, strutils, sequtils

proc solve1(data:seq[int]): int = 
  for k in 1 .. data.high:
    if data[k] > data[k - 1]:
      inc result

proc solve2(data: seq[int]): int =
  for k in 0 ..< (data.len - 3):
    if data[k + 3] > data[k]:
      inc result

let data = (getAppDir() / "aoc_2021_01.txt").lines.toSeq.map(parseInt)

echo "Answer Part 1: ", solve1(data)

echo "Answer Part 2: ", solve2(data)