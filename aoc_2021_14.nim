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


# Part 2, had to run this on my mac, raspberry pi failed with overflow error on counttable

polymer = data[0][0]

var letter_count =  toCountTable(polymer)


echo letter_count

var table:CountTable[string]

for i in 0..<polymer.len-1:
  table.inc(polymer[i..i+1])

echo table

for i in 1 .. 40:
  var new_table = table
  for key, letter_to_insert in rules:
    var left_side = key[0] & letter_to_insert
    var right_side = letter_to_insert & key[1]
    
    new_table.inc(key, 0)
    new_table.inc(left_side, 0)
    new_table.inc(right_side, 0)

    if key in table:
      if table[key] > 0:
        var val = table[key]

        if letter_count.contains(letter_to_insert[0]) == false:
          letter_count[letter_to_insert[0]] = val
        else:
          letter_count[letter_to_insert[0]] = letter_count[letter_to_insert[0]] + val
        
        new_table[key] = new_table[key] - val
        new_table.inc(left_side, val)
        new_table.inc(right_side, val)
    
  table = new_table

echo letter_count.largest.val - letter_count.smallest.val







 