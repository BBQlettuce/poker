class Hand

  attr_accessor :cards

  def initialize(cards)
    @cards = cards
  end

  def get_cards(new_cards)
    self.cards += new_cards
  end

  def drop_cards(indices, deck)
    raise if indices.any? { |idx| !idx.between?(0,4) }
    cards_to_return = []
    indices.each { |idx| cards_to_return << cards[idx] }
    deck.return(cards_to_return)
    cards_to_return.each { |card| self.cards.delete(card) }
  end
end
