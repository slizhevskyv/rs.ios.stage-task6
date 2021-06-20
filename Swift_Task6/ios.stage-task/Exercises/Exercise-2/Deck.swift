import Foundation

protocol DeckBaseCompatible: Codable {
    var cards: [Card] {get set}
    var type: DeckType {get}
    var total: Int {get}
    var trump: Suit? {get}
}

enum DeckType:Int, CaseIterable, Codable {
    case deck36 = 36
}

struct Deck: DeckBaseCompatible {

    //MARK: - Properties

    var cards = [Card]()
    var type: DeckType
    var trump: Suit?

    var total:Int {
        return type.rawValue
    }
}

extension Deck {

    init(with type: DeckType) {
        self.type = type
        self.cards = self.createDeck(suits: Suit.allCases, values: Value.allCases)
    }

    public func createDeck(suits:[Suit], values:[Value]) -> [Card] {
        var initialDeckCards: [Card] = [];

        for suit in suits {
            for value in values {
                initialDeckCards.append(Card(suit: suit, value: value));
            }
        }

        return initialDeckCards;
    }

    public mutating func shuffle() {
        self.cards.shuffle()
    }

    public mutating func defineTrump() {
        self.trump = cards.last!.suit;
        self.cards = self.cards.map({ card in
            Card(suit: card.suit, value: card.value, isTrump: card.suit == self.trump)
        })
    }

    public mutating func initialCardsDealForPlayers(players: [Player]) {
        for _ in 0..<6 {
            for player in players {
                let card = self.cards.removeLast()
                if player.hand != nil {
                    player.hand!.append(card);
                } else {
                    player.hand = [card];
                }
            }
        }
    }

    public func setTrumpCards(for suit:Suit) {

    }
}

