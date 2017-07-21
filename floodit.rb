#Ruby Gems 'console_splash' for the menu screen, and 'colorize' for colouring the String
require 'console_splash'
require 'colorize'

#High score as a global variable (because I do not want to call the damn thing in every method)
$high_score = 0

#Menu splash screen created
def menu
  menu = ConsoleSplash.new(29, 88)
  menu.write_header("Welcome to Flood-It", "written by Justin Onn", "version 1.2")
  menu.write_center(-5, "<Press enter to continue>")
  menu.write_horizontal_pattern("*")
  menu.write_vertical_pattern("*")
  menu.splash
  gets()
  main_menu(14, 9, $high_score)
end

#Main menu
def main_menu(width, height, highscore)
  puts "Main Menu"
  puts "s = Start game"
  puts "c = Change size"
  puts "q = Quit"
  if ($high_score > 0) then
    puts "Best game: #$high_score turns"
  else
    puts "No games played yet."
  end
  print "Please enter your choice: "
  input = gets.downcase.chomp
  if (input == "s") then
    start_game(width, height)
  elsif (input == "c") then
    print "Width (Currently #{width}): "
    width = gets.chomp.to_i
    print "Height (Currently #{height}): "
    height = gets.chomp.to_i
    $high_score = 0
    main_menu(width, height, 0)
  elsif (input == "q") then
    abort
  else
    main_menu(width, height, $high_score)
  end
end  


def get_board(width, height)
  #Assigning the 2-dimensional array with colours
  colours = [:red, :blue, :green, :yellow, :cyan, :magenta]
  board = Array.new(height) { Array.new(width) }
  (0..height-1).each do |column|
    (0..width-1).each do |cell|
      board[column][cell] = colours.sample
    end
  end
  return board
end

def display_board(board)
#Displaying the initial board with random colours
  board.each do |i|
    i.each do |j|
    print "  ".colorize(:background => j)
  end
    puts
end
end


#Initialization of the game
def start_game(width, height)
tries = 0
board = get_board(width, height)
repeat(tries, board, width, height)
  end

#Method for next game
def repeat(tries, board, width, height)
  display_board(board)
  percentage = completion_percentage(board, width, height)
  puts "Number of turns: #{tries}"
  if percentage == 100 then
    puts "You have won in #{tries} turns."
  #High Score System
  if $highscore
    if tries > $high_score then
      gets
      main_menu(width, height, $high_score)
    end
  end
  if $high_score = tries
    gets
    main_menu(width, height, $high_score)
  end
  end 
  puts "Current completion: #{percentage}%"
  print "Please choose an option: "
  input = gets.chomp
  board = update_colour(board, width, height, input, tries)
  #Increase the number of turns
  tries += 1
  #Repeat until completion
  repeat(tries, board, width, height)
end


def update_colour(board, width, height, input, tries)
  case input
      when "r"
      colour = :red
      when "g"
      colour = :green
      when "b"
      colour = :blue
      when "m"
      colour = :magenta
      when "y"
      colour = :yellow
      when "c"
      colour = :cyan
      when "q"
      main_menu(width, height, $high_score)
      else
      return board
    end
    oldColor = board[0][0]
    board = flood(board, colour, oldColor, 0, 0, width, height)
    return board
end

def completion_percentage(board, width, height)
  similarcells = 0.0
  board.each do |column|
    column.each do |cell|
    if cell == board[0][0] then
       similarcells += 1
    end
  end
end
percentage = ((similarcells/(width*height))*100).floor()
end

#Recursion method
def flood(board, newColor, oldColor, i, j, width, height)
  if i >=0 && j >= 0 && i < height && j < width && board[i][j] != newColor
    if board[i][j] == oldColor
      board[i][j] = newColor
      flood(board, newColor, oldColor, i+1, j, width, height)
      flood(board, newColor, oldColor, i-1, j, width, height)
      flood(board, newColor, oldColor, i, j+1, width, height)
      flood(board, newColor, oldColor, i, j-1, width, height)
    end
  end
  return board
end      

# TODO: Implement everything else as described in the
#       assignment brief.
menu