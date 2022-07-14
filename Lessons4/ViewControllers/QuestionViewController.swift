//
//  QuestionViewController.swift
//  Lessons4
//
//  Created by Oleksand Kovalov on 07.07.2022.
//

import UIKit

// MARK: - QuestionViewController
class QuestionViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet weak private var questionProgressView: UIProgressView!

    @IBOutlet weak private var questionLabel: UILabel!

    @IBOutlet weak private var singleStackView: UIStackView!
    @IBOutlet private var singleButtons: [UIButton]!

    @IBOutlet weak private var multipleStackView: UIStackView!
    @IBOutlet private var multipleLabels: [UILabel]!
    @IBOutlet private var multipleSwitches: [UISwitch]!

    @IBOutlet weak private var rangeStackView: UIStackView!
    @IBOutlet weak private var rangeSlider: UISlider!
    @IBOutlet private var rangeLabels: [UILabel]!


    // MARK: - Properties

    private let question = Question.getQuestion()
    private var questionIndex = 0
    private var answerChoosen: [Answer] = []
    private var answers: [Answer] {
        question[questionIndex].answers
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

private extension QuestionViewController {
    func setupUI() {
        setupNavigationController()
        for stackView in [singleStackView, multipleStackView, rangeStackView] {
            stackView?.isHidden = true
        }

        // Get current question
        let currentQuestion = question[questionIndex]

        // Set current questuion for question label
        questionLabel.text = currentQuestion.text

        // Calculate progress
        let totalProgress = Float(questionIndex) / Float(question.count)

        // Set progresss for progress question view
        questionProgressView.setProgress(totalProgress, animated: false)

        title = "Вопрос № \(questionIndex + 1) из \(question.count)"

        showCurrentAnswers(for: currentQuestion.type)
    }

    func showCurrentAnswers(for type: ResponseType) {

        switch type {
        case .single:
           showSingleStack(with: answers)
        case .mupltiple:
            showMultipleStackView(with: answers)
        case .ranged:
            showRangeStackView(with: answers)
        }
    }

    func showSingleStack(with answers: [Answer]) {
        singleStackView.isHidden = false

        for (button, answer) in zip(singleButtons, answers) {
            button.setTitle(answer.text, for: .normal)
        }
    }

    func showMultipleStackView(with answers: [Answer]) {
        multipleStackView.isHidden = false

        for (label, answer) in zip(multipleLabels, answers) {
            label.text = answer.text
        }
    }

    func showRangeStackView(with answer: [Answer]) {
        rangeStackView.isHidden = false

        rangeLabels.first?.text = answer.first?.text
        rangeLabels.last?.text = answer.last?.text
    }

    func setupNavigationController() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesBackButton = true
    }

    func nextQuestion() {
        questionIndex += 1

        if questionIndex < question.count {
            setupUI()
        } else {
            setUpResultController()
            // перейти на последний экран
        }
    }
}

// MARK: - Action

extension QuestionViewController {

    @IBAction func singlebuttonPressed(_ sender: UIButton) {
        guard let currentIndexButton = singleButtons.firstIndex(of: sender) else {
            return
        }

        let current = answers[currentIndexButton]
        answerChoosen.append(current)

        nextQuestion()
    }

    @IBAction func multipleButtonPressed() {
        for (mySwitch, answer) in zip(multipleSwitches, answers) {
            if mySwitch.isOn {
                answerChoosen.append(answer)
            }
        }

        nextQuestion()
    }

    @IBAction func rangeButtonPressed() {
        let index = lroundf(rangeSlider.value * Float(answers.count - 1)) // 2

        let currentAnswer = answers[index]
        answerChoosen.append(currentAnswer)

        nextQuestion()
    }
    
    func passArrayToThirdScreen() {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyboard.instantiateViewController(identifier: "ResultViewController") as! ResultViewController
    vc.modalPresentationStyle = .fullScreen
        vc.resultArray = answerChoosen
    navigationController?.pushViewController(vc, animated: true)
    }
    
    func setUpResultController() {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyboard.instantiateViewController(identifier: "ResultViewController") as! ResultViewController
    vc.modalPresentationStyle = .fullScreen

    navigationController?.pushViewController(vc, animated: true)
        
    }
}

    // 1. передать массив с ответами на этот экран
    // 2. определить наиболее часто встречаюшийся тип животного
    // 3. отобразить результаты на экране
    // 4. избавится от кнопки back

