require 'rubygems'
require 'httparty'

class App
  def run
    playerAnswer =''
    reqThrow = HTTParty.get('http://localhost:3000/api/v1/throws')
    puts "\n\nWelcome to Rock - Paper - Scissors! \n\nPress r for Rock\nPress s for Scissors\nPress p for Paper\n\n"
    playerAnswer = gets.chomp.downcase
    curbAnswer = reqThrow["item"]
    puts "\n\nCurb has chosen #{curbAnswer}"
    define_winner(curbAnswer, playerAnswer)
  end

  def define_winner(curbAns, playerAns)
    case [curbAns, playerAns ]
    when ['r' , 's'], ['s','p'], ['p', 'r']
      puts "\n\nYou lost!"
    when ['r' , 'r'], ['s','s'], ['p', 'p']
      puts "\n\nYou tied!"
    else
      puts "\n\nYou Won!"
    end
  end
end

def main
  app = App.new
  app.run
end

main