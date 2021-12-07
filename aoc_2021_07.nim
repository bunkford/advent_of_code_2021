import os, strutils, sequtils, algorithm, stats, math

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

proc solve2(crabs:seq[int]):int = 
  # floor works for my input, but not for test data. 
  # ceil works for test data, but not input
  # seems like mean just gets us close?
  # find which one actually uses the minimum fuel expenditure. 

  var m1 = floor(mean(crabs)).toInt
  var m2 = ceil(mean(crabs)).toInt
  var test1, test2:int

  for crab in crabs:
    test1.inc abs(crab - m1)
    for cost in 0 .. abs(crab - m1) - 1:
      test1.inc cost

  for crab in crabs:
    test2.inc abs(crab - m2)
    for cost in 0 .. abs(crab - m2) - 1:
      test2.inc cost

  return min(test1, test2)


let data = (getAppDir() / "aoc_2021_07.txt").lines.toSeq.mapIt(it.split(",").map(parseInt))[0]


echo "Answer Part 1: ", solve1(data)

echo "Answer Part 2: ", solve2(data)