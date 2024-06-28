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
    @Published var isWatering: Bool = false

    @ObservedObject var userViewModel: UserViewModel

    init(userViewModel: UserViewModel) {
        self.userViewModel = userViewModel
        self.plants = PlantManager.shared.loadPlants()
        if plants.isEmpty {
            addInitialPlant()
        }
        self.selectedPlant = plants.first(where: { $0.name == "Plant" })
    }
    
    private func addInitialPlant() {
        let initialPlant = Plant(name: "Plant", amountFlushed: 0, countFlushedtoFinish: 20)
        PlantManager.shared.addPlant(initialPlant)
        self.plants = PlantManager.shared.loadPlants()
        self.selectedPlant = initialPlant
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
        guard userViewModel.user.teapot > 0 else {
            print("Not enough teapots!")
            return
        }
        guard plant.amountFlushed < plant.countFlushedtoFinish else {
            print("Plant has already been fully flushed!")
            return
        }

        isWatering = true

        
        let updatedPlant = Plant(name: plant.name, amountFlushed: plant.amountFlushed + 1, countFlushedtoFinish: plant.countFlushedtoFinish)
        if let index = plants.firstIndex(of: plant) {
            plants[index] = updatedPlant
        }
        selectedPlant = updatedPlant

        let animationDuration: Double = 4.0

        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
            self.userViewModel.addTeapot(amount: -1)
            PlantManager.shared.updatePlant(updatedPlant)
            self.isWatering = false
        }
    }
    
    func selectPlant(_ plant: Plant) {
        selectedPlant = plant
    }
}
