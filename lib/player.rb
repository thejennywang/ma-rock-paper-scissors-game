class Player
  attr_reader :name
  attr_writer :picks

	def initialize(name)
		@name = name
	end

  def self.build_player(name, pick)
    player = new(name)
    player.picks= pick
    player
  end

	def pick
		@picks
	end

end