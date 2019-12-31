//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Luc Derosne on 30/12/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import SwiftUI

final class Favorites: ObservableObject {
    @Published private var resorts: Set<String>
    private let saveKey = "Favorites"
    
    init() {
        // load our saved data
        self.resorts = []
        if let data = UserDefaults.standard.data(forKey: saveKey){
            if let decodedData = try? JSONDecoder().decode(Set<String>.self, from: data){
                self.resorts = decodedData
            }
        }
    }
    
    var count: Int {
        resorts.count
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    func save(){
        if let encodedData = try? JSONEncoder().encode(resorts){
            UserDefaults.standard.set(encodedData, forKey: saveKey)
        }
    }
}
