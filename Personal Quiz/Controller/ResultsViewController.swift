//
//  ResultsViewController.swift
//  Personal Quiz
//
//  Created by Николай Петров on 18.02.2022.
//

import UIKit

class ResultsViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet var resultAnswerLable: UILabel!
    @IBOutlet var resultDefinitionLable: UILabel!
    
    
    // MARK: - Public properties
    var responses: [Answer]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        updateResult()
    }
    
    private func updateResult() {
        var frequencyOfAnimals: [AnimalType: Int] = [:]
        let animals =  responses.map { $0.type }
        
        for animal in animals {
            frequencyOfAnimals[animal] = (frequencyOfAnimals[animal] ?? 0 ) + 1
        }
        
        let sortedfrequencyOfAnimals = frequencyOfAnimals.sorted { $0.value > $1.value }
        guard let mostfrequencyAnimal = sortedfrequencyOfAnimals.first?.key else { return }
        
        updateUI(with: mostfrequencyAnimal)
        }
    
    private func updateUI(with animal: AnimalType) {
        resultAnswerLable.text = "Вы \(animal.rawValue)"
        resultDefinitionLable.text = ("\(animal.definition)")
    }
}
