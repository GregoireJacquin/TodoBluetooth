//
//  TodoItem.swift
//  TodoBluetooth
//
//  Created by Grégoire Jacquin on 14/10/2019.
//  Copyright © 2019 Grégoire Jacquin. All rights reserved.
//

import Foundation

struct TodoItem: Codable {
    var name: String
    var completed: Bool
    var createdAt: Date
    var itemIdentifier: UUID
    
    func saveItem(){
        
    }
    func deleteItem(){
        
    }
    func markAsCompleted(){
        
    }
}
