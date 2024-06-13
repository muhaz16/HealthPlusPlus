//
//  ExerciseModel.swift
//  HealthPlusPlus
//
//  Created by Lucas Bui on 13/9/2023.
//

import Foundation
struct Exercise: Codable, Identifiable {
    let id = UUID()
    var name: String
    var type: String
    var muscle: String
    var equipment: String
    var difficulty: String
    var instructions: String
}
// Ensure Exercise Conforms to hashable
extension Exercise: Hashable{
    func hash(into hasher: inout Hasher) {
        // Makes sure if two values have the same ID they have the same hash value
        hasher.combine(id)
    }
    
    static func ==(lhs: Exercise, rhs: Exercise) -> Bool {
        return lhs.id == rhs.id
    }
}
