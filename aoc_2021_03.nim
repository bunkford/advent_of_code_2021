import os, strutils, sequtils

proc solve1(data:seq[string]): int = 
  var count = newSeqWith(data[0].len, 0)
  for line in data:
    for k, v in line:
      if v == '1': count[k].inc
  let gamma = fromBin[int](count.mapIt(if it > data.len div 2: 1 else: 0).join)
  let epsilon = fromBin[int](count.mapIt(if it > data.len div 2: 0 else: 1).join)
  return gamma * epsilon

proc solve2(data:seq[string]): int = 
  # oxygen 
  var dta = data
  var i:int
  while dta.len > 1:
    var zeros, ones: seq[string]
    for k, v in dta:
      if v[i] == '1':
        ones.add(v)
      else:
        zeros.add(v)
    
    if ones.len >= zeros.len:
      dta = ones
    else:
      dta = zeros
    
    i.inc
  let oxygen = fromBin[int](dta.join)
 
  # reset variables and find co2
  dta = data 
  i = 0
  while dta.len > 1:
    var zeros, ones: seq[string]
    for k, v in dta:
      if v[i] == '1':
        ones.add(v)
      else:
        zeros.add(v)
    
    if ones.len < zeros.len:
      dta = ones
    else:
      dta = zeros
    
    i.inc
  let co2 = fromBin[int](dta.join)
  
  return oxygen * co2



let data = (getAppDir() / "aoc_2021_03.txt").lines.toSeq

echo "Answer Part 1: ", solve1(data) # 1082324

echo "Answer Part 2: ", solve2(data) # 1353024