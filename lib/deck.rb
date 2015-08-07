require_relative 'card'

class Deck

  def self.all_cards
    cards = []
    Card.values.each do |value|
      Card.suits.each do |suit|
        cards << Card.new(suit, value)
      end
    end

    cards
  end

  attr_accessor :cards

  def initialize(cards = self.class.all_cards)
    @cards = cards
  end

  def count
    cards.length
  end

  def take(n)
    cards.shift(n)
  end

  def return(returned_cards)
    @cards += returned_cards
  end

end
