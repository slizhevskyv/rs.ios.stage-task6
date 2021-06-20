//
//  Player.swift
//  DurakGame
//
//  Created by Дима Носко on 15.06.21.
//

import Foundation

protocol PlayerBaseCompatible {
    var hand: [Card]? { get set }
}

final class Player: PlayerBaseCompatible {
    var hand: [Card]?

    func checkIfCanTossWhenAttacking(card: Card) -> Bool {
        if let _hand = self.hand {
            let cardsInHandWithCardValue = _hand.filter({ $0.value == card.value });
            
            return cardsInHandWithCardValue.isEmpty ? false : true;
        }
        return false;
    }

    func checkIfCanTossWhenTossing(table: [Card: Card]) -> Bool {
        if let _hand = self.hand {
            for (firstCard, secondCard) in table {
                let cardsInHandWithCardValue = _hand.filter({ $0.value == firstCard.value || $0.value == secondCard.value });
                
                return cardsInHandWithCardValue.isEmpty ? false : true;
            }
        }
        
        return false;
    }
}
