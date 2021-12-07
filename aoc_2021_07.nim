import os, strutils, sequtils, algorithm, stats

proc solve1(crabs:seq[int]):int = 
  var median: int
  if crabs.high mod 2 == 1:
    var m1 = crabs.sorted()[(crabs.len div 2) - 1]
    var m2 = crabs.sorted()[(crabs.len div 2)]
    # because there is no middle value, median is the mean of the two middle values
    median = mean(@[m1, m2]).toInt
  else:
    median = parseFloat($(crabs.sorted()[(crabs.len div 2)])).toInt

  for crab in crabs:
    result.inc abs(crab - median)

proc solve2(data:seq[int]):int = 
  discard

let data = (getAppDir() / "aoc_2021_07.txt").lines.toSeq.mapIt(it.split(",").map(parseInt))[0]


echo "Answer Part 1: ", solve1(data)

echo "Answer Part 2: ", solve2(data)