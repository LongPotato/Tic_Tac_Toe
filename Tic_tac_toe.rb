class Game

	def initialize
		@player1 = Player.new('X')
		@player2 = Player.new('O')
		@game_board = Board.new
	end

	def start
		instruction		#display game instruction
		while !@player1.win? && !@player2.win? && !draw?
			get_turn(@player1, @name1)
			if !@player1.win? && !draw?
				get_turn(@player2, @name2)
			end
		end
		#when the game is over
		if @player1.win?
			puts "---------------------------------------------------"
			puts "#{@name1} wins!"
			puts "---------------------------------------------------"
		elsif @player2.win?
			puts "---------------------------------------------------"
			puts "#{@name2} wins!"
			puts "---------------------------------------------------"
		else
			puts "---------------------------------------------------"
			puts "It's a draw!"
			puts "---------------------------------------------------"
		end
	end

	private

		def instruction
			puts "---------------------------------------------------"
			puts "Welcome to Tic Tac Toe!"
			print "Player 1, please enter your name: "
			@name1 = gets.chomp
			print "Player 2, please enter your name: "
			@name2 = gets.chomp
			puts "---------------------------------------------------"

			puts "Here's the game board"
			puts "-------"
			puts "|1|2|3|"
			puts "|-|-|-|"
			puts "|4|5|6|"
			puts "|-|-|-|"
			puts "|7|8|9|"
			puts "-------"
			puts "The player who succeeds in placing three respective marks \
					in a horizontal, vertical, or diagonal row wins the game."
			puts "---------------------------------------------------"	
			puts
		end

		def draw?
			return (not @game_board.board.values.include?(" ")) && (not @player1.win?) && (not @player2.win?)
		end
		
		def get_turn(player, player_name)
			move = get_move(player, player_name)	#get user input and validate move
			player.make_move(@game_board, move)
			@game_board.display						#display the game board after move
		end

		def get_move(player, player_name)
			print "#{player_name} enter your move: "
			while choice = gets.chomp.to_i
				if @game_board.available_cell.include?(choice)
					return choice
				else
					print "Unavailable cell, please choose again: "
				end
			end
		end

end


class Player
	attr_accessor :symbol, :player_move

	@@win_condition = [ [1,2,3], [4,5,6], [7,8,9],
						[1,4,7], [2,5,8], [3,6,9],
						[1,5,9], [3,5,7] ]

	def initialize(symbol)
		@symbol = symbol
		@player_move = Hash[ (1..9).map { |position| [position, false] } ]		#create a hash table to track player's moves
	end

	def make_move(game_board, position)
		game_board.update(position, @symbol)
		@player_move[position] = true		#mark the cell player chose
	end

	def win?		#check for win condition
		player_moves = @player_move.keys.select { |position| @player_move[position] == true } 	#collect player chosen cells
		if @@win_condition.include? (player_moves)		#check with inside win_condition
			return true
		else
			return false
		end
	end

end


class Board
	attr_accessor :board

	def initialize
		@board = Hash[ (1..9).map { |position| [position, " "] } ]
	end

	def display
		puts "-------"
		puts "|#{@board[1]}|#{@board[2]}|#{@board[3]}|"
		puts "|-|-|-|"
		puts "|#{@board[4]}|#{@board[5]}|#{@board[6]}|"
		puts "|-|-|-|"
		puts "|#{@board[7]}|#{@board[8]}|#{@board[9]}|"
		puts "-------"
	end

	def update(position, player)
		@board[position] = player
	end

	def available_cell
		return @board.keys.select { |position| @board[position] == " " }		#return all empty cells
	end

end


Game.new.start
print "Replay (Y/N)?: "
choice = gets.chomp.downcase
case choice
	when "y"
		Game.new.start
end



