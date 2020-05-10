//
//  BOViewModel.swift
//  BirdObserver
//
//  Created by Benjamin Mecanovic on 03/05/2020.
//  Copyright © 2020 hydro1337x. All rights reserved.
//

import Foundation

class BOViewModel {
    
    // MARK: - Constants
    private let UDKey = "saveBirdData"
    private let colorKey = "colorKey"
    private let counterKey = "counterKey"
    
    // MARK: - Properties
    private let userDefaults = UserDefaults.standard
    final var birdCounter: LiveData<Int> = LiveData(0)
    final var currentColor: LiveData<BirdColor> = LiveData(.none)
    
    enum BirdColor: Int, CaseIterable {
        case red = 1
        case green = 2
        case blue = 3
        case yellow = 4
        case none = 5
    }
    
    // MARK: - Init
    init() {
        fetch()
    }
    
    // MARK: - Methods
    final func setBirdColor(to color: BirdColor) {
        birdCounter.value += 1
        currentColor.value = color
        save()
    }
    
    final func reset() {
        currentColor.value = .none
        birdCounter.value = 0
        delete()
    }
    
    private func save() {
        let color = currentColor.value.rawValue
        let counter = birdCounter.value
        let data: [String: Any] = [colorKey: color, counterKey: counter]
        userDefaults.set(data, forKey: UDKey)
    }
    
    private func fetch() {
        let dict = userDefaults.dictionary(forKey: UDKey)
        if let data = dict, let color = data[colorKey] as? Int, let counter = data[counterKey] as? Int {
            birdCounter.value = counter
            currentColor.value = BirdColor(rawValue: color) ?? .none
        }
    }
    
    private func delete() {
        userDefaults.removeObject(forKey: UDKey)
    }
}
