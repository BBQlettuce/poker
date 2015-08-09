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
    if royal_flush?
      COMBO_TO_SCORE["royal_flush"]
    elsif straight_flush?
      COMBO_TO_SCORE["straight_flush"]
    elsif four_of_a_kind?
      COMBO_TO_SCORE["four_of_a_kind"]
    elsif full_house?
      COMBO_TO_SCORE["full_house"]
    elsif flush?
      COMBO_TO_SCORE["flush"]
    elsif straight?
      COMBO_TO_SCORE["straight"]
    elsif three_of_a_kind?
      COMBO_TO_SCORE["three_of_a_kind"]
    elsif two_pair?
      COMBO_TO_SCORE["two_pair"]
    elsif one_pair?
      COMBO_TO_SCORE["one_pair"]
    else
      COMBO_TO_SCORE["junk"]
    end
  end

  def all_same_suit?
    suits = cards.map { |card| card.suit }
    suits.uniq.length == 1
  end

  def all_in_order?
    values = cards.map { |card| card.score }
    sorted_uniqs = values.sort.uniq
    (sorted_uniqs.length == 5) && (sorted_uniqs.last - sorted_uniqs.first == 4)
  end

  def highest_card
    highest = nil
    cards.each do |card|
      highest = card if highest.nil? || highest.score < card.score
    end
    highest
  end

  def royal_flush?
    all_same_suit? && all_in_order? && highest_card.value == :ace
  end

  def straight_flush?
    all_same_suit? && all_in_order? && highest_card.value != :ace
  end

  def four_of_a_kind?

  end

  def full_house?
  end

  def flush?
    all_same_suit? && !all_in_order?
  end

  def straight?
    all_in_order? && !all_same_suit?
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
