//
//  ResultScreenViewController.swift
//  Flag Contest
//
//  Created by Yavuz Güner on 6.05.2022.
//

import UIKit

class ResultScreenViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    
    var resultNumber:Int? //Doğru sayısı
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.hidesBackButton = true
        
        if let correct = resultNumber {
            resultLabel.text = "\(correct) Correct \(5-correct) Wrong "
            percentageLabel.text = "%\(correct*100/5) Success Rate"
        }
    }
    

    @IBAction func againButton(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
}
