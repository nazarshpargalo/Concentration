 //
//  Card.swift
//  ConcentrationNew
//
//  Created by Назарій on 18.04.2020.
//  Copyright © 2020 Назарій Шпаргало. All rights reserved.
//

import Foundation
 
 struct Card
 {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    private static var identifierFactory = 0
    
    private  static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return  identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
 }
