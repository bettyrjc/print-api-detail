//
//  ViewController.swift
//  starWars_project
//
//  Created by BETTY JIMENEZ on 24/4/23.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var ship: UILabel!
    @IBOutlet weak var name: UILabel!
    var dataManager = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        dataManager.delegate = self
        name.text = "Pricensa Leah"
    }

  
    @IBAction func getAnswerUser(_ sender: UIButton) {
        let userAnswer = sender.titleLabel!.text!
        dataManager.getPerson(number:userAnswer)
    }
    
}
extension ViewController: DataManagerDelegate{
    func didUpdateData(nameValue: String) {
        DispatchQueue.main.async {
            self.name.text = nameValue
        }
    }
    
    func didFailWithError(error: Error) {
        print("_______ERROR_______", error)
    }
    
}

