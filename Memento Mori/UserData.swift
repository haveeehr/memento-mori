//
//  UserData.swift
//  Memento Mori
//
//  Created by Javier Fransiscus on 17/07/24.
//

import Foundation

class UserData: ObservableObject {
    @Published var birthdate: Date? {
        didSet {
            if let birthdate = birthdate {
                UserDefaults.standard.set(birthdate, forKey: "birthdate")
            }
        }
    }
    
    init() {
        self.birthdate = UserDefaults.standard.object(forKey: "birthdate") as? Date
    }
}
