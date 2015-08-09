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
    let(:weaker_straight_flush) { Hand.new(
      [Card.new(:hearts, :nine),
        Card.new(:hearts, :eight),
        Card.new(:hearts, :queen),
        Card.new(:hearts, :jack),
        Card.new(:hearts, :ten)]) }
    let(:four_of_a_kind) { Hand.new(
      [Card.new(:hearts, :ace),
        Card.new(:spades, :ace),
        Card.new(:clubs, :ace),
        Card.new(:diamonds, :ace),
        Card.new(:hearts, :ten)]) }
    let(:weaker_four_of_a_kind) { Hand.new(
      [Card.new(:hearts, :four),
        Card.new(:spades, :four),
        Card.new(:clubs, :four),
        Card.new(:diamonds, :four),
        Card.new(:hearts, :ten)]) }
    let(:full_house) { Hand.new(
      [Card.new(:hearts, :ace),
        Card.new(:spades, :ace),
        Card.new(:clubs, :ace),
        Card.new(:hearts, :jack),
        Card.new(:diamonds, :jack)]) }
    let(:weaker_full_house) { Hand.new(
      [Card.new(:hearts, :five),
        Card.new(:spades, :five),
        Card.new(:clubs, :five),
        Card.new(:hearts, :jack),
        Card.new(:diamonds, :jack)]) }
    let(:flush) { Hand.new(
      [Card.new(:hearts, :ace),
        Card.new(:hearts, :king),
        Card.new(:hearts, :queen),
        Card.new(:hearts, :jack),
        Card.new(:hearts, :three)]) }
    let(:weaker_flush) { Hand.new(
      [Card.new(:hearts, :six),
        Card.new(:hearts, :deuce),
        Card.new(:hearts, :queen),
        Card.new(:hearts, :jack),
        Card.new(:hearts, :three)]) }
    let(:straight) { Hand.new(
      [Card.new(:hearts, :ace),
        Card.new(:diamonds, :king),
        Card.new(:clubs, :queen),
        Card.new(:spades, :jack),
        Card.new(:hearts, :ten)]) }
    let(:weaker_straight) { Hand.new(
      [Card.new(:hearts, :nine),
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
    let(:weaker_three_of_a_kind) { Hand.new(
      [Card.new(:hearts, :four),
        Card.new(:spades, :four),
        Card.new(:clubs, :four),
        Card.new(:hearts, :jack),
        Card.new(:hearts, :ten)]) }
    let(:two_pair) { Hand.new(
      [Card.new(:hearts, :ace),
        Card.new(:spades, :ace),
        Card.new(:hearts, :jack),
        Card.new(:clubs, :jack),
        Card.new(:hearts, :ten)]) }
    let(:weaker_two_pair) { Hand.new(
      [Card.new(:hearts, :three),
        Card.new(:spades, :three),
        Card.new(:hearts, :jack),
        Card.new(:clubs, :jack),
        Card.new(:hearts, :ten)]) }
    let(:one_pair) { Hand.new(
      [Card.new(:hearts, :ace),
        Card.new(:spades, :ace),
        Card.new(:hearts, :queen),
        Card.new(:hearts, :jack),
        Card.new(:hearts, :ten)]) }
    let(:weaker_one_pair) { Hand.new(
      [Card.new(:hearts, :seven),
        Card.new(:spades, :seven),
        Card.new(:hearts, :queen),
        Card.new(:hearts, :jack),
        Card.new(:hearts, :ten)]) }
    let(:junk) { Hand.new(
      [Card.new(:hearts, :ace),
        Card.new(:spades, :king),
        Card.new(:clubs, :queen),
        Card.new(:diamonds, :eight),
        Card.new(:hearts, :three)]) }
    let(:weaker_junk) { Hand.new(
      [Card.new(:hearts, :ace),
        Card.new(:spades, :king),
        Card.new(:clubs, :four),
        Card.new(:diamonds, :eight),
        Card.new(:hearts, :three)]) }

    describe "#identify_combo" do
      it "identifies royal flush" do
        expect(royal_flush.identify_combo).to eq("royal flush")
      end
      it "identifies straight flush (excluding royal flush)" do
        expect(straight_flush.identify_combo).to eq("straight flush")
      end
      it "identifies four of a kind" do
        expect(four_of_a_kind.identify_combo).to eq("four of a kind")
      end
      it "identifies full house" do
        expect(full_house.identify_combo).to eq("full_house")
      end
      it "identifies flush (excluding royal and straight flush)" do
        expect(flush.identify_combo).to eq("flush")
      end
      it "identifies straight (excluding royal and straight flush)" do
        expect(straight.identify_combo).to eq("straight")
      end
      it "identifies three of a kind" do
        expect(three_of_a_kind.identify_combo).to eq("three of a kind")
      end
      it "identifies two pair" do
        expect(two_pair.identify_combo).to eq("two pair")
      end
      it "identifies one pair" do
        expect(one_pair.identify_combo).to eq("one_pair")
      end
      #it "identifies high card"
    end

    describe "#beats?" do
      it "returns true if hand beats other hand" do
        expect(royal_flush.beats?(straight_flush)).to be true
        expect(straight_flush.beats?(weaker_straight_flush)).to be true
        expect(weaker_straight_flush.beats?(four_of_a_kind)).to be true
        expect(four_of_a_kind.beats?(weaker_four_of_a_kind)).to be true
        expect(weaker_four_of_a_kind.beats?(full_house)).to be true
        expect(full_house.beats?(weaker_full_house)).to be true
        expect(weaker_full_house.beats?(flush)).to be true
        expect(flush.beats?(weaker_flush)).to be true
        expect(weaker_flush.beats?(straight)).to be true
        expect(straight.beats?(weaker_straight)).to be true
        expect(weaker_straight.beats?(three_of_a_kind)).to be true
        expect(three_of_a_kind.beats?(weaker_three_of_a_kind)).to be true
        expect(weaker_three_of_a_kind.beats?(two_pair)).to be true
        expect(two_pair.beats?(weaker_two_pair)).to be true
        expect(weaker_two_pair.beats?(one_pair)).to be true
        expect(one_pair.beats?(weaker_one_pair)).to be true
        expect(weaker_one_pair.beats?(junk)).to be true
        expect(junk.beats?(weaker_junk)).to be true
      end

    end

  end

end
