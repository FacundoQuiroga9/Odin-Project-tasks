require_relative 'tic-tac-toe'

puts "Welcome to TIC-TAC-TOE"
game = Tic_tac_toe.new
puts "#{game.current_turn} turn"
game.display_board

while  game.winner.nil? do
puts "Select row"
row = gets.chomp.to_i

puts "Select column"
column = gets.chomp.to_i

game.mark_board(row, column)

game.display_board

  if game.winner
    puts "#{game.winner} wins"
  end

end
