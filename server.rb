require 'sinatra/base'
require 'newrelic_rpm'
require_relative 'lib/player'
require_relative 'lib/game'

class RockPaperScissors < Sinatra::Base
  get '/' do
    erb :index
  end

  get '/new-game' do
    erb :new_player
  end

  post '/register' do 
    @player = params[:name]
    erb :play 
  end

  post "/play" do
    player = Player.new(params[:name])
    player.picks = params[:pick]
    computer = generate_computer
    @game = Game.new(player, computer)
    erb :outcome
  end

  post "/playvscomputer" do
    @game = ComputerVsHumanGame.new(build_player)
    erb :outcome
  end

  def build_player
    Player.build_player(params[:name], params[:pick])
  end

  def generate_computer
    choice = ["Rock","Paper","Scissors"].sample

    comp = Player.new("computer")
    comp.picks = choice
    comp
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
