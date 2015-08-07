require 'rspec'
require 'deck'
require 'card'

describe Deck do

  subject(:deck) { Deck.new }
  let(:random_cards) { [Card.new(:hearts, :king), Card.new(:spades, :queen)] }

  describe "#initialize" do
    let(:random_deck) { Deck.new(random_cards) }

    it "initializes with 52 playing cards if nothing is passed" do
      expect(deck.cards.length).to eq(52)
    end
    it "initializes with given cards if an argument is passed" do
      expect(random_deck.cards).to eq(random_cards)
    end
  end

  describe "::all_cards" do
    let(:cards_value_suit) { Deck.all_cards.map { |c| [c.value, c.suit] } }
    let(:unique_cards_value_suit) do
      Deck.all_cards.map { |c| [c.value, c.suit] }.uniq
    end

    it "returns an array of 52 cards" do
      expect(Deck.all_cards.length).to eq(52)
    end
    it "returns unique card objects only" do
      expect(Deck.all_cards.uniq).to eq(Deck.all_cards)
    end
    it "returns unique cards only" do
      expect(cards_value_suit).to eq(unique_cards_value_suit)
    end
  end

  describe "#count" do
    it "returns the number of cards in the deck" do
      allow(deck).to receive(:cards).and_return([1,2,3])
      expect(deck.count).to eq(3)
    end
  end

  describe "#take" do
    let(:taken_cards) { deck.cards[0..1] }
    it "takes the first 'n' cards from the top of the deck" do
      expect(taken_cards).to eq(deck.take(2))
    end

    it "removes taken cards from the deck" do
      deck.take(2)
      expect(deck.cards.count).to eq(50)
    end
  end

  describe "#return" do
    context "when cards are returned" do
      before(:each) do
        deck.return(random_cards)
      end
      it "returns the cards back to the deck" do
        expect(deck.cards[-2..-1]).to eq(random_cards)
      end
    end
  end


end
