//
//  ViewController.swift
//  Lessons4
//
//  Created by Oleksand Kovalov on 07.07.2022.
//

import UIKit

class StartViewController: UIViewController {

    let questions = Question.getQuestion()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    @IBAction func didTapStart() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "question") as! QuestionViewController
        vc.modalPresentationStyle = .fullScreen

        navigationController?.pushViewController(vc, animated: true)
    }
}
