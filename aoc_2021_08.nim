import os, strutils, sequtils, tables, algorithm

proc solve1(data:seq[seq[seq[string]]]): int = 
  for line in data:
    for digit in line[1]:
      if digit.len in [2, 3, 4, 7]:
        result.inc

proc shared_segments(known:Table[int, seq[char]], digit:string, check: int):int =
  if known.hasKey(check):
    for c in known.getOrDefault(check, @[]):
      if c in digit.toSeq:
        result.inc

proc solve2(data:seq[seq[seq[string]]]): int =
  for line in data:
    var known = initTable[int, seq[char]]()

    for digit in line[0]: # 1, 4, 7, 8 are known based on their length
      if digit.len == 2:
        known[1] = digit.toSeq
      elif digit.len == 3:
        known[7] = digit.toSeq
      elif digit.len == 4:
        known[4] = digit.toSeq
      elif digit.len == 7:
        known[8] = digit.toSeq

    for digit in line[0]: # need to loop again because we need to make sure we have captured 1 and 4
      if digit.len == 5: # == numbers 2, 3, 5
        if shared_segments(known, digit, 4) == 3 and shared_segments(known, digit, 1) == 1:
          known[5] = digit.toSeq
        elif shared_segments(known, digit, 4) == 3 and shared_segments(known, digit, 1) == 2:
          known[3] = digit.toSeq
        else:
          known[2] = digit.toSeq

    for digit in line[0]: # have to loop again, because we need to know the segments for #5
      if digit.len == 6: # == numbers 6, 9, 0
        if shared_segments(known, digit, 1) == 1:
          known[6] = digit.toSeq
        elif shared_segments(known, digit, 5) == 5:
          known[9] = digit.toSeq 
        else:
          known[0] = digit.toSeq 
    
    # decode the digits in line[1]
    var decoded:seq[int]
    for digit in line[1]:
      for k, v in known.pairs:
        if v.sorted() == digit.toSeq.sorted():
          decoded.add(k)
    result.inc(decoded.join.parseInt())


let data = (getAppDir() / "aoc_2021_08.txt").lines.toSeq.mapIt(it.split(" | ").mapIt(it.split()))
s
echo "Answer Part 1: ", solve1(data)

echo "Answer Part 2: ", solve2(data)