import os, strutils, sequtils, tables

proc solve1(data:seq[seq[seq[int]]]):int = 
  # for part 1, only consider input where x1 == x2 or y1 == y2
  var coord_counts = initCountTable[seq[int]]()
  for coords in data:
    if coords[0][0] == coords[1][0] or coords[0][1] == coords[1][1]:
      for x in min(coords[0][0], coords[1][0]) .. max(coords[0][0], coords[1][0]):
        for y in min(coords[0][1], coords[1][1]) .. max(coords[0][1], coords[1][1]):
          coord_counts.inc(@[x, y])

  for k, c in coord_counts:
    if c >= 2: 
      result.inc

  #[
  # Test map data
  var board:seq[seq[char]]
  for y in 0 .. 10:
    var l:seq[char]
    for x in 0 .. 10:
      if coord_counts[@[x, y]] == 0: l.add('.')
      else: l.add($(coord_counts[@[x, y]]))
    board.add(l)

  for l in board:
    echo l.join
  ]#

proc solve2(data:seq[seq[seq[int]]]):int = 
   # for part 1, only consider input where x1 == x2 or y1 == y2
  var coord_counts = initCountTable[seq[int]]()
  for coords in data:
    if coords[0][0] == coords[1][0] or coords[0][1] == coords[1][1]: # vertical and horizontal
      for x in min(coords[0][0], coords[1][0]) .. max(coords[0][0], coords[1][0]):
        for y in min(coords[0][1], coords[1][1]) .. max(coords[0][1], coords[1][1]):
          coord_counts.inc(@[x, y])
    else: # diaganols
      var steps = max(abs(coords[0][0] - coords[1][0]), abs(coords[0][1] - coords[1][1]))
      var x2 = coords[1][0]
      var y2 = coords[1][1]
      for i in 0 .. steps:
        coord_counts.inc(@[x2, y2])
        x2.inc if coords[0][0] > coords[1][0]: 1 else: -1 # increase or decrease depending on which way we are going
        y2.inc if coords[0][1] > coords[1][1]: 1 else: -1

  for k, c in coord_counts:
    if c >= 2: 
      result.inc
  
  #[
  # Test map data
  var board:seq[seq[char]]
  for y in 0 .. 10:
    var l:seq[char]
    for x in 0 .. 10:
      if coord_counts[@[x, y]] == 0: l.add('.')
      else: l.add($(coord_counts[@[x, y]]))
    board.add(l)

  for l in board:
    echo l.join
  ]#


let data = (getAppDir() / "aoc_2021_05.txt").lines.toSeq.mapIt(it.split(" -> ").mapIt(it.split(",").map(parseInt)))

echo "Answer Part 1: ", solve1(data)

echo "Answer Part 2: ", solve2(data)