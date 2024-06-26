//
//  PlantManager.swift
//  Flourish
//
//  Created by Agfi on 26/06/24.
//

import Foundation

class PlantManager {
    static let shared = PlantManager()
    private let userDefaultsKey = "plants"
    
    private init() {}
    
    func savePlants(plants: [Plant]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(plants) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
        }
    }
    
    func loadPlants() -> [Plant] {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey),
           let loadedPlants = try? JSONDecoder().decode([Plant].self, from: data) {
            return loadedPlants
        }
        return []
    }
    
    func addPlant(_ plant: Plant) {
        var plants = loadPlants()
        plants.append(plant)
        savePlants(plants: plants)
    }
    
    func updatePlant(_ updatedPlant: Plant) {
        var plants = loadPlants()
        if let index = plants.firstIndex(where: { $0.name == updatedPlant.name }) {
            plants[index] = updatedPlant
            savePlants(plants: plants)
        }
    }
}
