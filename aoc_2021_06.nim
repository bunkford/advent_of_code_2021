import os, strutils, sequtils

type
  LanternFish = object
    spawnTimer: int

proc solve1(data:seq[int], days:int):int = 
  var sea:seq[LanternFish] 
  for timer in data:
    sea.add(LanternFish(spawnTimer: timer))

  for i in 1 .. days: # 80 days
    var fish_to_add:int = 0
    for fish in 0 .. sea.high:
     
      sea[fish].spawnTimer.dec
      if sea[fish].spawnTimer < 0:
        sea[fish].spawnTimer = 6
        fish_to_add.inc(1)

    sea = sea & repeat(LanternFish(spawnTimer: 8), fish_to_add)

    #[
    # debug test data
    var debug: seq[int]
    for fish in sea:
      debug.add(fish.spawnTimer)
    echo "After ", align($i, 2), " days: ", debug
    ]#
  
  return sea.len

  
proc solve2(data:seq[int], days:int):int64 = 
  var counts = newSeq[int64](9)
  for i in 0 .. counts.high:
    counts[i] = data.count(i)

  for day in 1 .. days:
    var new_counts = newSeq[int64](9)
    for i in countdown(counts.high, 0):
      if i == 0:
        new_counts[8] = counts[0]
        new_counts[6] += counts[0]
      else:
        new_counts[i-1] = counts[i]

    counts = new_counts

  result = counts.foldl(a + b)  


let data = (getAppDir() / "aoc_2021_06.txt").lines.toSeq.mapIt(it.split(",").map(parseInt))[0]


echo "Answer Part 1: ", solve1(data, 80)

echo "Answer Part 2: ", solve2(data, 256)