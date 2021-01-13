#!/usr/bin/env ruby

require 'set'

class TicTacToe

  attr_accessor :player1, :player2

  # Initialize the players names and a empty board
  #
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @board = [[" "," "," "],
              [" "," "," "],
              [" "," "," "]]
  end

  private

  # Display the board with current values
  #
  def display_board
    puts("-----------")
    @board.each do |row|
      row.each_with_index do |col, i|
        if (i % 2) == 1
          print("| #{col} |")
        else
          print(" #{col} ")
        end
      end
      print("\n")
      puts("-----------")
    end
  end

  # Check for any empty spaces in the board, if not present
  # return true to end the game
  #
  def check_game_over
    # Check for empty places
    @board.each do |row|
      if row.include?(" ")
        return false
      else
        return true
      end
    end
  end
  
  # Get the position to place the value from the user.
  # Test for vaild input, if invalid ask until valid 
  # input is provided
  #
  def get_pos
    while true do
      pos = gets.chomp
      pos = pos.split
      if ('0'..'2').include?(pos[0]) and ('0'..'2').include?(pos[1])
        i, j = pos[0].to_i, pos[1].to_i
        if @board[i][j] == " "
          break
        end
      end
      print("Invalid position, enter again: ")
    end
    return i, j
  end

  # Check the values in all positions that determine the winner,
  # if satisfied return a string with winner name else return
  # a string stating the game is tied
  #
  def check_winner
    # Check for row match
    #
    @board.each do |row|
      if row.to_set == Set['O']
        return "#{@player1} is the winner."
      elsif row.to_set == Set['X']
        return "#{@player2} is the winner."
      end
    end

    # Check for coloumn match
    #
    i = 0
    while i < 3 do
        if @board[0][i] == @board[1][i] and @board[2][i] == @board[0][i]
          if @board[0][i] == 'O'
            return "#{@player1} is the winner."
          elsif @board[0][i] == 'X'
            return "#{@player2} is the winner."
          end
        end
        i += 1
    end

    # Check for diagonal match
    #
    if @board[0][0] == @board[1][1] and @board[0][0] == @board[2][2]
      if @board[0][0] == 'O'
        return "#{@player1} is the winner."
      elsif @board[0][0] == 'X'
        return "#{@player2} is the winner."
      end
    elsif @board[2][0] == @board[1][1] and @board[2][0] == @board[0][2]
      if @board[2][0] == 'O'
        return "#{@player1} is the winner."
      elsif @board[2][0] == 'X'
        return "#{@player2} is the winner."
      end
    end
    return "It's a tie."
  end

  public

  # Start the game by calling display_board method,
  # player details and pass the turn for each player
  # until the game ends
  #
  def start_game
    k = 0 # Keep count of players turns

    # Loop until game ends
    #
    until check_game_over do
      puts
      display_board
      puts
      puts "#{@player1}'s symbol 'O'; #{@player2}'s symbol'X'"
      if (k % 2) == 0
        print "#{@player1}'s turn, enter the position (eg: 0 1): "
        i, j = get_pos
        @board[i][j] = 'O'
      else
        print "#{@player2}'s turn, enter the position (eg: 0 2): "
        i, j = get_pos
        @board[i][j] = 'X'
      end
      winner = check_winner
      unless winner == "It's a tie."
        break
      end
      k += 1
    end 
    puts
    display_board
    puts

    return winner
  end
end

#####################################################
#puts("\n\t\t\t   Tic Tac Toe")
puts <<-'EOF'
   _____ _        _____            _____
  |_   _(_) ___  |_   _|_ _  ___  |_   _|__   ___
    | | | |/ __|   | |/ _` |/ __|   | |/ _ \ / _ \
    | | | | (__    | | (_| | (__    | | (_) |  __/
    |_| |_|\___|   |_|\__,_|\___|   |_|\___/ \___|

EOF
puts("\n\t\t-----------------")
puts("\t\t 0 0 | 0 1 | 0 2 ")
puts("\t\t-----------------")
puts("\t\t 1 0 | 1 1 | 1 2 ")
puts("\t\t-----------------")
puts("\t\t 2 0 | 2 1 | 2 2 ")
puts("\t\t-----------------")
puts

print("Enter the name of player 1: ")
player1 = gets.chomp
print("Enter the name of player 2: ")
player2 = gets.chomp

# Instance of the class
game = TicTacToe.new(player1, player2)

winner = game.start_game 
puts(winner)
