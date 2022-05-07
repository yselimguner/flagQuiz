//
//  QuizScreenViewController.swift
//  Flag Contest
//
//  Created by Yavuz Güner on 6.05.2022.
//

import UIKit

class QuizScreenViewController: UIViewController {

    //Soru Sayısı
    @IBOutlet weak var questionNumberLabel: UILabel!
    
    //Yanlış Cevaplar
    @IBOutlet weak var wrongLabel: UILabel!
    
    //Doğru Cevaplar
    @IBOutlet weak var correctLabel: UILabel!
    
    //Resim
    @IBOutlet weak var flagImageView: UIImageView!
    
    
    @IBOutlet weak var aButton: UIButton!
    @IBOutlet weak var bButton: UIButton!
    @IBOutlet weak var cButton: UIButton!
    @IBOutlet weak var dButton: UIButton!
    
    var questions = [Flags]()
    var wrongChoises = [Flags]()
    var correctQuestion = Flags() //Tek seçenek olduğu için.
    
    var questionCounter = 0
    var correctCounter = 0
    var wrongCounter = 0
    
    //Seçenekleri karıştırmak için yazıyoruz.
    var choices = [Flags]()
    var mixChoicesList = Set <Flags>() //Hashable yapmak için Flags sınıfına protocol eklicez.
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        questions = Flagsdao().get5RandomFlags()
        
        for s in questions {
            print(s.flag_name!)
        }
        loadQuestion()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let toViewController = segue.destination as! ResultScreenViewController
        toViewController.resultNumber = correctCounter
    }
    
    
    func loadQuestion() {
        questionNumberLabel.text = "\(questionCounter+1). QUESTION"
        correctLabel.text = "Correct : \(correctCounter)"
        wrongLabel.text = "Wrong : \(wrongCounter)"
        
        //Doğru soruyu yazıyoruz.
        correctQuestion = questions[questionCounter]
        flagImageView.image = UIImage(named: correctQuestion.flag_image!)
        wrongChoises = Flagsdao().get3WrongFlags(flag_id: correctQuestion.flag_id!)
        
        mixChoicesList.removeAll()
        
        mixChoicesList.insert(correctQuestion)
        mixChoicesList.insert(wrongChoises[0])
        mixChoicesList.insert(wrongChoises[1])
        mixChoicesList.insert(wrongChoises[2])
        
        choices.removeAll()
        
        //Yukarıda karıştırdığım seçenekleri sırayla eklerim
        for i in mixChoicesList {
            choices.append(i)
        }
        
        aButton.setTitle(choices[0].flag_name, for: .normal)
        bButton.setTitle(choices[1].flag_name, for: .normal)
        cButton.setTitle(choices[2].flag_name, for: .normal)
        dButton.setTitle(choices[3].flag_name, for: .normal)

    }
    
    func trueControl(button:UIButton) {
        //butonun üstündeki yazı ile doğru cevabı kıyaslandırmak için yaparız.
        let buttonWrite = button.titleLabel?.text
        let correctAnswer = correctQuestion.flag_name
        
        
        if correctAnswer == buttonWrite {
            correctCounter += 1
        }else {
            wrongCounter += 1
        }
        print("Tıkladığımız buton: \(buttonWrite!)")
        print("Doğru Cevap: \(correctAnswer!)")
    }
    
    func questionControlCounter() {
        questionCounter += 1
        
        if questionCounter != 5 {
            loadQuestion()
        }else {
            performSegue(withIdentifier: "toResultScreen", sender: nil)
        }
    }
    
    @IBAction func aClickButton(_ sender: Any) {
        trueControl(button: aButton)
        questionControlCounter()
    }
    @IBAction func bClickButton(_ sender: Any) {
        trueControl(button: bButton)
        questionControlCounter()
    }
    @IBAction func cClickButton(_ sender: Any) {
        trueControl(button: cButton)
        questionControlCounter()
    }
    @IBAction func dClickButton(_ sender: Any) {
        trueControl(button: dButton)
        questionControlCounter()
    }
    
    
}
