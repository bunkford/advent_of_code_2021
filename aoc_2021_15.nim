import os, strutils, sequtils, astar, heapqueue

type
    Grid = seq[seq[int]]
        ## A matrix of nodes. Each cell is the cost of moving to that node

    Point = tuple[x, y: int]
        ## A point within that grid

template yieldIfExists( grid: Grid, point: Point ) =
    ## Checks if a point exists within a grid, then calls yield it if it does
    let exists =
        point.y >= 0 and point.y < grid.len and
        point.x >= 0 and point.x < grid[point.y].len
    if exists:
        yield point

iterator neighbors( grid: Grid, point: Point ): Point =
    ## An iterator that yields the neighbors of a given point
    yieldIfExists( grid, (x: point.x - 1, y: point.y) )
    yieldIfExists( grid, (x: point.x + 1, y: point.y) )
    yieldIfExists( grid, (x: point.x, y: point.y - 1) )
    yieldIfExists( grid, (x: point.x, y: point.y + 1) )

proc cost*(grid: Grid, a, b: Point): int =
    ## Returns the cost of moving from point `a` to point `b`
    grid[a.y][a.x]

proc heuristic*( grid: Grid, node, goal: Point ): int =
    max(abs(node.x - goal.x), abs(node.y - goal.y))

proc inflate(grid: Grid, times: int): Grid =
  # repeat current grid x times in both directions
  result = grid.mapIt(it.cycle(times))
  result = result.cycle(times)

  # increase risk valves by 1 in each iteration, wrapping 10 back to 1
  for y, row in mpairs(result):
    for x, val in mpairs(row):
      let (cx, cy) = (x div grid.len, y div grid.len)
      val = (val + cx + cy - 1) mod 9 + 1


proc part1(grid: seq[seq[int]]): int = 
  let start: Point = (x: 0, y: 0)
  let goal: Point = (x: grid.high, y: grid[0].high)

  for point in path[Grid, Point, float](grid, start, goal):
      if point != start:
        result += grid.cost(point, point)

let grid = (getAppDir() / "aoc_2021_15.txt").lines.toSeq.mapIt(it.toSeq.mapIt(($it).parseInt))

echo "Answer Part 1: ", part1(grid)

echo "Answer Part 2: ", part1(grid.inflate(5))

