require 'hand'
require 'card'
require 'rspec'

describe Hand do

  context "when manipulating cards" do

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
      it "removes cards from the hand based on index, and returns to deck" do
        allow(dummy_hand).to receive(:cards).and_return([1,2,3,4,5])
        expect(dummy_deck).to receive(:return)
        dummy_hand.drop_cards([1,3], dummy_deck)
        expect(dummy_hand.cards).to eq([1,3,5])
      end
      it "accepts only indeces from 0 to 4" do
        expect{ dummy_hand.drop_cards([6], dummy_deck) }.to raise_error
      end
    end

  end

  context "when evaluating cards" do
    let(:royal_flush) { Hand.new(
      [Card.new(:hearts, :ace),
        Card.new(:hearts, :king),
        Card.new(:hearts, :queen),
        Card.new(:hearts, :jack),
        Card.new(:hearts, :ten)]) }
    let(:straight_flush) { Hand.new(
      [Card.new(:hearts, :nine),
        Card.new(:hearts, :king),
        Card.new(:hearts, :queen),
        Card.new(:hearts, :jack),
        Card.new(:hearts, :ten)]) }
    let(:four_of_a_kind) { Hand.new(
      [Card.new(:hearts, :ace),
        Card.new(:spades, :ace),
        Card.new(:clubs, :ace),
        Card.new(:diamonds, :ace),
        Card.new(:hearts, :ten)]) }
    let(:full_house) { Hand.new(
      [Card.new(:hearts, :ace),
        Card.new(:spades, :ace),
        Card.new(:clubs, :ace),
        Card.new(:hearts, :jack),
        Card.new(:diamonds, :jack)]) }
    let(:flush) { Hand.new(
      [Card.new(:hearts, :ace),
        Card.new(:hearts, :king),
        Card.new(:hearts, :queen),
        Card.new(:hearts, :jack),
        Card.new(:hearts, :three)]) }
    let(:straight) { Hand.new(
      [Card.new(:hearts, :ace),
        Card.new(:diamonds, :king),
        Card.new(:clubs, :queen),
        Card.new(:spades, :jack),
        Card.new(:hearts, :ten)]) }
    let(:three_of_a_kind) { Hand.new(
      [Card.new(:hearts, :ace),
        Card.new(:spades, :ace),
        Card.new(:clubs, :ace),
        Card.new(:hearts, :jack),
        Card.new(:hearts, :ten)]) }
    let(:two_pair) { Hand.new(
      [Card.new(:hearts, :ace),
        Card.new(:spades, :ace),
        Card.new(:hearts, :jack,
        Card.new(:clubs, :jack),
        Card.new(:hearts, :ten)]) }
    let(:one_pair) { Hand.new(
      [Card.new(:hearts, :ace),
        Card.new(:spades :ace),
        Card.new(:hearts, :queen),
        Card.new(:hearts, :jack),
        Card.new(:hearts, :ten)]) }
    # let(:high_card) { Hand.new(
    #   [Card.new(:hearts, :ace),
    #     Card.new(:spades, :king),
    #     Card.new(:clubs, :queen),
    #     Card.new(:diamonds, :eight),
    #     Card.new(:hearts, :three)]) }

    describe "#identify_combo" do
      it "identifies royal flush" do
        expect(royal_flush.identify_combo).to eq("royal flush")
      end
      it "identifies straight flush (excluding royal flush)"
        expect(straight_flush.identify_combo).to eq("straight flush")
      it "identifies four of a kind"
        expect(four_of_a_kind.identify_combo).to eq("four of a kind")
      it "identifies full house"
        expect(full_house.identify_combo).to eq("full_house")
      it "identifies flush (excluding royal and straight flush)"
        expect(flush.identify_combo).to eq("flush")
      it "identifies straight (excluding royal and straight flush)"
        expect(straight.identify_combo).to eq("straight")
      it "identifies three of a kind"
        expect(three_of_a_kind.identify_combo).to eq("three of a kind")
      it "identifies two pair"
        expect(two_pair.identify_combo).to eq("two pair")
      it "identifies one pair"
        expect(one_pair.identify_combo).to eq("one_pair")
      #it "identifies high card"
    end

  end

end
