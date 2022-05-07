//
//  ViewController.swift
//  Flag Contest
//
//  Created by Yavuz Güner on 6.05.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        copyDatabase()
    }

    func copyDatabase() {
        let bundlePath = Bundle.main.path(forResource: "flagquiz", ofType: ".db")
        
        let targetPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let fileManager = FileManager.default
        
        let placeToCopy = URL(fileURLWithPath: targetPath).appendingPathComponent("flagquiz.db")
        
        if fileManager.fileExists(atPath: placeToCopy.path) {
            print("Database already exist. No need to copy.")
        }else {
            do{
                try fileManager.copyItem(atPath: bundlePath!, toPath: placeToCopy.path)
            }catch{
                print(error.localizedDescription)
            }
        }
    }

}

