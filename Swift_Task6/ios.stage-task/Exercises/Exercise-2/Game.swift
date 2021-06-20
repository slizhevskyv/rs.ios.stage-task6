//
//  Game.swift
//  DurakGame
//
//  Created by Дима Носко on 16.06.21.
//

import Foundation

typealias FirstAttackingPlayer = (value: Value, player: Player);

protocol GameCompatible {
    var players: [Player] { get set }
}

struct Game: GameCompatible {
    var players: [Player]
}

extension Game {

    func defineFirstAttackingPlayer(players: [Player]) -> Player? {
        var firstAttackingPlayer: FirstAttackingPlayer?
        
        for player in players {
            if let playerHand = player.hand {
                for card in playerHand {
                    if (card.isTrump) {
                        if let fap = firstAttackingPlayer {
                            if (card.value.rawValue < fap.value.rawValue) {
                                firstAttackingPlayer = (card.value, player);
                            }
                        } else {
                            firstAttackingPlayer = (card.value, player);
                        }
                    }
                }
            }
        }
        
        return firstAttackingPlayer?.player;
    }
}
