//
//  QuestionViewController.swift
//  Personal Quiz
//
//  Created by Николай Петров on 18.02.2022.
//

import UIKit

class QuestionViewController: UIViewController {
    
    // MARK: - IB Outlets
    
    @IBOutlet var questionProgreesView: UIProgressView!
    @IBOutlet var questionLable: UILabel!
    
    @IBOutlet var singleStackView: UIStackView!
    @IBOutlet var singleButtons: [UIButton]!
    
    @IBOutlet var multipleStackView: UIStackView!
    @IBOutlet var multipleLabels: [UILabel]!
    @IBOutlet var multipleSwitches: [UISwitch]!
    
    @IBOutlet var rangedStackView: UIStackView!
    @IBOutlet var rangedLabels: [UILabel]!
    @IBOutlet var rangedSlider: UISlider!
        
    // MARK: - Privet Properties
    
    private let question = Question.getQuestion()
    private var questionIndex = 0
    private var answersChoosen: [Answer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    // MARK: - IB Actions
    
    @IBAction func singelAnswerButtonPresed(_ sender: UIButton) {
        let carrentAnswers = question[questionIndex].answers
        guard let currentIndex = singleButtons.firstIndex(of: sender) else { return }
        let currentAnswer = carrentAnswers[currentIndex]
        answersChoosen.append(currentAnswer)
        
        nextQuestion()
    }
    
    @IBAction func miltipleAnswersButtonPresed() {
        let currentAnswers = question[questionIndex].answers
        
        for (multipleSwitch, answer) in zip(multipleSwitches, currentAnswers) {
            if multipleSwitch.isOn {
                answersChoosen.append(answer)
            }
        }
        
        nextQuestion()
    }
    
    @IBAction func rangedAnswerButtonPresed() {
        let currentAnswers = question[questionIndex].answers
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))
        answersChoosen.append(currentAnswers[index])
        
        nextQuestion()
    }
    
    
    // MARK: - Privet Methods
    
    // Update user interface
    private func updateUI() {
        //hide everething
        for stakView in [singleStackView, multipleStackView, rangedStackView] {
            stakView?.isHidden = true
        }
        
        //Get current question
        let currentQuestion = question[questionIndex]
        
        // Set current question for question lable
        questionLable.text = currentQuestion.text
        
        // calculate progress
        let totalProgress = Float(questionIndex) / Float(question.count)

        // Set progress for question progress view
        questionProgreesView.setProgress(totalProgress, animated: true)
        
        // Set navigation title
        title = "Вопрос № \(questionIndex + 1) из \(question.count)"
        
        let currentAnswers = currentQuestion.answers
        
        // Show stack view corresponding to question type
        switch currentQuestion.type {
        case .single:
            updateSingleStackView(using: currentAnswers)
        case .multiple:
            updateMultipleStackView(using: currentAnswers)
        case .ranged:
            updateRangedStackView(using: currentAnswers)
        }
    }
    
    
    /// Setup sigle stack view
    /// - Parameter answers: - array with answer
    ///
    /// Description of method
    private func updateSingleStackView(using answers: [Answer]) {
        // Sgow single stack view
        singleStackView.isHidden = false
        
        for (button, answer) in zip(singleButtons, answers) {
            button.setTitle(answer.text, for: .normal)
        }
    }
    
    private func updateMultipleStackView(using answers: [Answer]) {
        // Sgow single stack view
        multipleStackView.isHidden = false
        
        for (lable, answer) in zip(multipleLabels, answers) {
            lable.text = answer.text
        }
    }
    
    private func updateRangedStackView(using answers: [Answer]) {
        // Sgow single stack view
        rangedStackView.isHidden = false
        
        rangedLabels.first?.text = answers.first?.text
        rangedLabels.last?.text = answers.last?.text
    }
    
    // MARK: - Navigation
    
    //Show next question or go to the next screen
    private func nextQuestion() {
        questionIndex += 1
        if questionIndex < question.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "resultSegie", sender: nil)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "resultSegie" else { return }
        let resultVC = segue.destination as! ResultsViewController
        resultVC.responses = answersChoosen
    }
    
}
