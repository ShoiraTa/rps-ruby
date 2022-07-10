require 'rubygems'
require 'httparty'
require 'io/console'

class App
  attr_reader :values
  attr_accessor :playerAnswer, :curbAnswer

  def  initialize
    @playerAnswer = ''
    @curbAnswer = HTTParty.get('https://rock-paper-scissors-sh.herokuapp.com/api/v1/throws')["item"]
    @values = {:r => "Rock", :p => "Paper", :s => "Scissors"}
  end

  def run
    puts"#{'-' * 40} \nNew game: \n\nPress r for Rock\nPress s for Scissors\nPress p for Paper\nPress q to quit"
    playerAnswer = gets.chomp.downcase
    exit if playerAnswer== 'q'
    if ['r','s','p'].include? playerAnswer    
      define_winner(curbAnswer[0], playerAnswer)
    else
      puts 'Please choose r, s, or p'
      run
    end
  end

  def define_winner(curbAns, playerAns)
    $stdout.clear_screen
    case [curbAns, playerAns ]
      when ['r' , 's'], ['s','p'], ['p', 'r']
        puts "\nYou lost!"
      when ['r' , 'r'], ['s','s'], ['p', 'p']
        puts "\nYou tied!"
      else
        puts "\nYou Won!"
    end
    puts "\nYou have chosen #{values[playerAns.to_sym]}"
    puts "Curb has chosen #{values[curbAns.to_sym]}"
    sleep(3)
    $stdout.clear_screen
    run
  end
end

def main
  app = App.new
  $stdout.clear_screen
  puts "#{'-' * 40}\n\nWelcome to Rock - Paper - Scissors!\n\n"
  app.run
end

main