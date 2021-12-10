import os, strutils, sequtils, tables, aoc

proc solve1(data:seq[string]): int = 
  const brackets = {'(':')','[':']','{':'}','<':'>'}.toTable # matching brackets
  const scores = {')':3,']':57,'}':1197,'>':25137}.toTable # scores for wrong closing bracket

  for line in data:
    var stack:string
    for ch in line.toSeq:
      if brackets.hasKey(ch):
        stack = brackets[ch] & stack
      elif stack[0] == ch:
        stack = stack[1..^1]
      else:
        result.inc(scores[ch])
        break # already found one wrong on this line

proc solve2(data: seq[string]): int =
  const brackets = {'(':')','[':']','{':'}','<':'>'}.toTable # matching brackets
  const scores = {')':1,']':2,'}':3,'>':4}.toTable
  var line_scores:seq[int]

  for line in data:
    var stack:string
    var corrupt:bool
    for ch in line.toSeq:
      if brackets.hasKey(ch):
        stack = brackets[ch] & stack
      elif stack[0] == ch:
        stack = stack[1..^1]
      else:
        corrupt = true
        break # line corrupt
    if not corrupt:
      var line_score:int
      for ch in stack:
        line_score = line_score * 5 + scores[ch]
      line_scores.add(line_score)
  
  return line_scores.median

let data = (getAppDir() / "aoc_2021_10.txt").lines.toSeq

echo "Answer Part 1: ", solve1(data)

echo "Answer Part 2: ", solve2(data)