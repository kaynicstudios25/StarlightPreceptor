//
//  Item.swift
//  MyFirstProject
//
//  Created by Kaylyn Groom on 2/3/26.
//


import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
