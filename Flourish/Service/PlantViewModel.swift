//
//  PlantViewModel.swift
//  Flourish
//
//  Created by Agfi on 26/06/24.
//

import Foundation
import SwiftUI
import Combine

class PlantViewModel: ObservableObject {
    @Published var plants: [Plant] = []
    @Published var selectedPlant: Plant?
    @Published var user: User = UserManager.shared.getCurrentUser()
    
    init() {
        self.plants = PlantManager.shared.loadPlants()
        if plants.isEmpty {
            addInitialPlant()
        }
        self.selectedPlant = plants.first(where: { $0.name == "Plant" })
    }
    
    private func addInitialPlant() {
        let initialPlant = Plant(name: "Plant", amountFlushed: 0, countFlushedtoFinish: 50)
        PlantManager.shared.addPlant(initialPlant)
        self.plants = PlantManager.shared.loadPlants()
    }
    
    func addPlant(name: String, amountFlushed: Int, countFlushedtoFinish: Int) {
        let newPlant = Plant(name: name, amountFlushed: amountFlushed, countFlushedtoFinish: countFlushedtoFinish)
        PlantManager.shared.addPlant(newPlant)
        self.plants = PlantManager.shared.loadPlants()
    }
    
    func flushSelectedPlant() {
        guard let plant = selectedPlant else {
            print("No plant selected!")
            return
        }
        
        // Check if the plant has already reached the finish count
        if plant.amountFlushed >= plant.countFlushedtoFinish {
            print("Plant has already been fully watered!")
            return
        }
        
        // Check if there are enough teapots to water the plant
        guard user.teapot > 0 else {
            print("Not enough teapots!")
            return
        }
        
        // Update the teapots count
        user.teapot -= 1
        UserManager.shared.saveCurrentUser()
        
        // Update the flushed plant
        let updatedPlant = Plant(name: plant.name, amountFlushed: plant.amountFlushed + 1, countFlushedtoFinish: plant.countFlushedtoFinish)
        PlantManager.shared.updatePlant(updatedPlant)
        
        // Update the plants array
        if let index = plants.firstIndex(where: { $0.name == updatedPlant.name }) {
            plants[index] = updatedPlant
            
            // Dispatch UI update on the main queue
            DispatchQueue.main.async {
                // Update selectedPlant to reflect the flushed plant
                self.selectedPlant = updatedPlant
            }
        }
    }
    
    func selectPlant(_ plant: Plant) {
        selectedPlant = plant
    }
}
