class Hand

  COMBO_TO_SCORE = {
    "royal_flush" => 9,
    "straight_flush" => 8,
    "four_of_a_kind" => 7,
    "full_house" => 6,
    "flush" => 5,
    "straight" => 4,
    "three_of_a_kind" => 3,
    "two_pair" => 2,
    "one_pair" => 1,
    "junk" => 0
  }
  attr_accessor :cards

  def initialize(cards)
    @cards = cards
  end

  def get_cards(new_cards)
    self.cards += new_cards
  end

  def drop_cards(indices, deck)
    raise if !indices.all? { |idx| idx.between?(0,4) }
    cards_to_return = []
    indices.each { |idx| cards_to_return << cards[idx] }
    deck.return(cards_to_return)
    cards_to_return.each { |card| self.cards.delete(card) }
  end

  def identify_combo
    case self
    when royal_flush?
      COMBO_TO_SCORE["royal_flush"]
    when straight_flush?
      COMBO_TO_SCORE["straight_flush"]
    when four_of_a_kind?
      COMBO_TO_SCORE["four_of_a_kind"]
    when full_house?
      COMBO_TO_SCORE["full_house"]
    when flush?
      COMBO_TO_SCORE["flush"]
    when straight?
      COMBO_TO_SCORE["straight"]
    when three_of_a_kind?
      COMBO_TO_SCORE["three_of_a_kind"]
    when two_pair?
      COMBO_TO_SCORE["two_pair"]
    when one_pair?
      COMBO_TO_SCORE["one_pair"]
    else
      COMBO_TO_SCORE["junk"]
    end
  end

  def royal_flush?
  end
  def straight_flush?
  end
  def four_of_a_kind?
  end
  def full_house?
  end
  def flush?
  end
  def straight?
  end
  def three_of_a_kind?
  end
  def two_pair?
  end
  def one_pair?
  end

  def beats?(other_hand)
  end

end
