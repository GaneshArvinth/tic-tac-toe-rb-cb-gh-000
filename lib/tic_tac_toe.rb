WIN_COMBINATIONS = [
  [0,1,2], [3,4,5], [6,7,8],
  [0,3,6], [1,4,7], [2,5,8],
  [0,4,8], [2,4,6]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(index)
  index.to_i - 1
end

def valid_move?(board, index)

  if(board[index]=="X" || board[index] == "O")
    puts "Position is not empty"
    return false
  elsif(!index.between?(0,8))
    puts "Enter a value between 1 and 9"
    return false
  else
    return true
  end
end

def move(board,index,symbol)
  board[index] = symbol
end

def position_taken?(board,index)
  valid = valid_move?(board,index)

  if(valid == false)
    return true
  else
    return false
  end
end

def turn_count(board)
  count = 0
  index = 0

  while(index<9)

    if(board[index] == "X" || board[index] == "O")
      count+=1
    end

    index+=1
  end

  count
end

def current_player(board)
  player = turn_count(board)

  if(player%2 == 0)
    return "X"
  else
    return "O"
  end
end

def turn(board)
  puts "Enter the position"
  user_input = gets.strip
  index = input_to_index(user_input)

  position_state = valid_move?(board,index)
  symbol = current_player(board)

  if(position_state == true)
    move(board,index,symbol)
  else
    turn(board)
  end

end

def won?(board)
  countX = 0
  countO = 0
  combinations = 0

  while(combinations<8)

    WIN_COMBINATIONS[combinations].each do |index|

          if(board[index] == "X")
            countX+=1
          elsif(board[index] == "O")
            countO+=1
          end

    end

          combinations+=1

          if(countX == 3 || countO == 3)
            return true
          elsif(combinations<8)
            next
          else
            return false
          end

    end
end

def full?(board)
  board.all? do |index|
    index == "X" || index == "O"
  end
end

def draw?(board)
  won = won?(board)
  full = full?(board)

  if (won == false && full == true)
    return true
  else
    return false
  end
end

def over?(board)
  won = won?(board)
  full = full?(board)
  draw = draw?(board)

  if(won == true || full == true || draw == true)
    return true
  else
    return false
  end
end

def winner(board)
  player = current_player(board)

  if(player == "X")
    return "X"
  else
    return "O"
  end
end

def play(board)
  turn(board)
  full = full?(board)
  won = won?(board)
  draw = draw?(board)
  over = over?(board)

    if (won == true)
      winner(board)
    elsif (draw == true)
      puts "Draw"
    elsif (full == false)
      play(board)
    end

end
