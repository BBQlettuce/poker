require 'hand'
require 'rspec'

describe Hand do

  let(:dummy_cards) { Array.new(5) { double(:Card) } }
  let(:dummy_hand) { Hand.new(dummy_cards) }
  # describe "#initialize" do
  #   it "initializes with given set of cards"
  # end

  describe "#cards" do

    it "returns the cards in an array of length 5" do
      expect(dummy_hand.cards).to eq(dummy_cards)
    end

  end

  describe "#get_cards" do
    it "adds cards to the hand" do
      dummy_hand.get_cards(["card"])
      expect(dummy_hand.cards.last).to eq("card")
    end
  end

  describe "#drop_cards" do
    let(:dummy_deck) { double(:Deck) }
    it "removes cards from the hand based on index" do
      allow(dummy_hand).to receive(:cards).and_return([1,2,3,4,5])
      dummy_hand.drop_cards([1,3], dummy_deck)
      expect(dummy_hand.cards).to eq([1,3,5])
    end
    it "accepts only indeces from 0 to 4" do
      expect(dummy_hand.drop_cards([6], dummy_deck)).to raise_error
    end
    it "returns the cards to the deck" do
      expect(dummy_deck).to receive(:return)
      dummy_hand.drop_cards([1], dummy_deck)
    end

  end



  describe "#identify_combo" do
    it "identifies royal flush"
    it "identifies straight flush"
    it "identifies four of a kind"
    it "identifies full house"
    it "identifies flush (excluding royal and straight flush)"
    it "identifies straight (excluding royal and straight flush)"
    it "identifies three of a kind"
    it "identifies two pair"
    it "identifies one pair"
    it "identifies high card"
  end

end
