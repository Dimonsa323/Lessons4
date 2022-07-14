//
//  ResultViewController.swift
//  Lessons4
//
//  Created by Oleksand Kovalov on 07.07.2022.
//

import UIKit

class ResultViewController: UIViewController {

    // MARK: Properties
    
    var resultArray: [Answer]  = []
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countAnimalType()
        backButtonVC()
    }

}

// MARK: Extension

private extension ResultViewController {
    func countAnimalType() {
        var frequencyOfAnimals: [AnimalType: Int] = [:]
        let animals = resultArray.map { $0.type }
        
        for animal in animals {
            if let animalTypeCount = frequencyOfAnimals[animal] {
                frequencyOfAnimals.updateValue(animalTypeCount + 1, forKey: animal)
            }  else {
                frequencyOfAnimals[animal] = 1
            }
        }
        let sortedFrequencyOfAnimals = frequencyOfAnimals.sorted { $0.value > $1.value }
        
        guard let mostFrequencyOfAnimals = sortedFrequencyOfAnimals.first?.key else { return }
       // не знаю куда присвоить mostFrequencyOfAnimals
    }
//        var catCounter = 0
//        var turtleCounter = 0
//        var dogCounter = 0
//        var rabbitCounter = 0
//
//    for (answer, type) in resultArray {
//        switch answer.type {
//        case .cat:
//            catCounter += 1
//        case .dog:
//            dogCounter += 1
//        case .rabbit:
//            rabbitCounter += 1
//        case .turtle:
//            turtleCounter += 1
//        }
//    }
//}
    
    
     func backButtonVC() {
        navigationItem.hidesBackButton = true
    }
}
