import os, strutils, sequtils, aoc

proc solve1(nums:seq[int], boards:seq[seq[int]]):int = 
  # write a checker to check boards for winning combinations adding 1 number each time
  var num_to_call = 5
  var called_nums:seq[int] = nums[0 .. 4]

  while true:
    for board_number, board in boards:
      # check horizontals
      for i in [0, 5, 10, 15, 20]:
        let hline = board[i .. i + 4]
        var found: int
        for n in hline:
          if n in called_nums:
            found.inc()
        if found == 5:
          return boards[board_number].filterIt(it notin called_nums).foldl(a + b) * called_nums.pop()

      # check verticals
      for a in 0 .. 4:
        var vline= @[board[a]]
        for b in 1 .. 4:
          vline.add(board[a + (5 * b)])
        var found: int
        for n in vline:
          if n in called_nums:
            found.inc()
        if found == 5:
          return boards[board_number].filterIt(it notin called_nums).foldl(a + b) * called_nums.pop()
    
    called_nums.add(nums[num_to_call])
    num_to_call.inc()



proc solve2(nums:seq[int], boards:seq[seq[int]]):int = 
  # write a checker to check boards for winning combinations adding 1 number each time
  var num_to_call = 5
  var called_nums:seq[int] = nums[0 .. 4]
  var winning_boards:seq[int]

  while winning_boards.len < boards.len:
    for board_number, board in boards:
      # check horizontals
      for i in [0, 5, 10, 15, 20]:
        let hline = board[i .. i + 4]
        var found: int
        for n in hline:
          if n in called_nums:
            found.inc()
        if found == 5:
          if board_number notin winning_boards: winning_boards.add(board_number)
          break

      # check verticals
      for a in 0 .. 4:
        var vline= @[board[a]]
        for b in 1 .. 4:
          vline.add(board[a + (5 * b)])
        var found: int
        for n in vline:
          if n in called_nums:
            found.inc()
        if found == 5:
          if board_number notin winning_boards: winning_boards.add(board_number)
          break
    
    called_nums.add(nums[num_to_call])
    num_to_call.inc()
  
  return boards[winning_boards[^1]].filterIt(it notin called_nums[0..^2]).foldl(a + b) * called_nums[^2]


proc get_inputs(filename:string):(seq[int], seq[seq[int]]) =
  # add input to variables
  var line_num:int
  var nums:seq[int]
  var boards:seq[seq[int]]
  var board:seq[int]
  for line in filename.lines:
    if line_num == 0:
      nums = line.split(",").map(parseInt)
    else:
      if line.len == 0: # new card
        if board.len > 0:
          boards.add(board)
        board = @[]
      else:
        board.add(line.splitWhitespace.map(parseInt))

    line_num.inc 
  boards.add(board)
  return (nums, boards)


let inputs = get_inputs(getAppDir() / "aoc_2021_04.txt")

echo "Answer Part 1: ", solve1(inputs[0], inputs[1])

echo "Answer Part 2: ", solve2(inputs[0], inputs[1])