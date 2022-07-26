import os, strutils, sequtils, seq2d

var data = (getAppDir() / "aoc_2021_13.txt").lines.toSeq.mapIt(it.split(","))

proc getGrid(data:seq[seq[string]]): Seq2D[string] =
  # returns grid size (x, y)
  var i, x, y:int
  while data[i][0] != "":
    if parseInt(data[i][0]) > x: x = parseInt(data[i][0])
    if parseInt(data[i][1]) > y: y = parseInt(data[i][1])
    inc i
  var grid = newSeq2D[string](x + 1, y + 1)
  i = 0
  while data[i][0] != "":
    grid[parseInt(data[i][0]), parseInt(data[i][1])] = "#"
    inc i
  return grid

proc fold(pos: int, dir: char, grid:var Seq2D[string]): Seq2D[string] =
  echo "Folding..."
  if dir == 'y':
    for x in 0 ..< grid.width:
      grid[x, pos] = "-"
      for y in pos + 1 ..< grid.height:
        # do the actual folding
        if grid[x, y] == "#":
          grid[x, abs(y - (pos * 2))] = "#"
          grid[x, y] = ""
  if dir == 'x':
    for y in 0 ..< grid.height:
      grid[pos, y] = "|"
      for x in pos + 1 ..< grid.width:
        # do the actual folding
        if grid[x, y] == "#":
          grid[abs(x - (pos * 2)), y] = "#"
          grid[x, y] = ""

  return grid

proc countVisible(grid: Seq2D[string]): int =
  for x, y, value in grid.items:
    if value == "#": inc result

var grid = getGrid(data)

proc viewGrid(grid:Seq2D[string]) =
  # view grid
  let f = open("aoc_2021_13_part2.txt", fmWrite)
  defer: f.close()
  var line:int
  var line_seq:seq[string]
  for x, y, value in grid.items:
    if line != y:
      f.writeLine(line_seq.join)
      line_seq = @[]
      line = y
    line_seq.add(if value == "": " " else: value)
  echo "Check aoc_2021_13_part2.txt for code for part 2..."

# could have parsed input for these values, but there aren't many, so hardcoded
grid = fold(655, 'x', grid)
echo "Part 1: ", countVisible(grid), " visible"
grid = fold(447, 'y', grid)
grid = fold(327, 'x', grid)
grid = fold(223, 'y', grid)
grid = fold(163, 'x', grid)
grid = fold(111, 'y', grid)
grid = fold(81, 'x', grid)
grid = fold(55, 'y', grid)
grid = fold(40, 'x', grid)
grid = fold(27, 'y', grid)
grid = fold(13, 'y', grid)
grid = fold(6, 'y', grid)
viewGrid(grid)