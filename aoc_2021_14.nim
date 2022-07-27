import os, strutils, sequtils, tables

var data = (getAppDir() / "aoc_2021_14.txt").lines.toSeq.mapIt(it.split(" -> "))

var polymer = data[0][0] 
var rules = map(data[2..^1], proc(x: seq[string]): (string, string) = (x[0], x[1])).toTable

for step in 1 .. 10:
  var i:int
  while i < polymer.len - 1:
    var pair = polymer[i] & polymer[i + 1]
    var insert = rules[pair]
    polymer = polymer[0..i] & insert & polymer[i+1..<polymer.len]
    i.inc 2

  let leterFrequencies = polymer.toCountTable()
  

  echo "step ", step ,": ", leterFrequencies.largest[1] - leterFrequencies.smallest[1]