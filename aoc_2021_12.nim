import os, strutils, sequtils, tables

var data = (getAppDir() / "aoc_2021_12.txt").lines.toSeq.mapIt(it.split("-"))

# map all the connecting caves
var map = initTable[string, seq[string]]()
for cave in data:
  if not map.hasKey(cave[0]): map[cave[0]] = @[]
  map[cave[0]].add(cave[1])
  if not map.hasKey(cave[1]): map[cave[1]] = @[]
  map[cave[1]].add(cave[0])

proc isLargeCave(c:string):bool = 
  if ord(c[0]) >= 97 and ord(c[0]) <= 122:
    return false
  return true

proc solve1(cave:string = "start", seen: seq[string] = @["start"]): int =  
  for c in map[cave]:
    if c == "end": 
      result.inc(1)
      # echo seen & @["end"]
    elif c.isLargeCave()  or c notin seen:
      # assumes no large caves are connected, 
      # which in the test cases and my input - they aren't!
      result.inc(solve1(c, seen & @[c]))


proc solve2(cave:string = "start", seen: seq[string] = @["start"], small_seen_twice:bool = false): int =  
  for c in map[cave]:
    if c == "end": 
      result.inc(1)
      # echo seen & @["end"]
    elif c != "start":
      if  c.isLargeCave():
        # assumes no large caves are connected, 
        # which in the test cases and my input - they aren't!
        result.inc(solve2(c, seen, small_seen_twice))
      else:
        if c notin seen:
          # small cave that we haven't been to yet
          result.inc(solve2(c, seen & @[c], small_seen_twice))
        elif not small_seen_twice:
          # small cave in seen, but we haven't visited one twice yet.
          result.inc(solve2(c, seen, true))
  
echo "Answer Part 1: ", solve1()
echo "Answer Part 2: ", solve2()
    

