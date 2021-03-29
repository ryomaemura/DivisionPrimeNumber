//
//  ViewController.swift
//  DivisionPrimeNumber
//
//  Created by Maemura Ryo on 2021/03/21.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var primeNumberLabel: UILabel!
  
  @IBOutlet weak var number2Label: UIButton!
  @IBOutlet weak var number3Label: UIButton!
  @IBOutlet weak var number5Label: UIButton!
  @IBOutlet weak var number7Label: UIButton!
  @IBOutlet weak var number11Label: UIButton!
  @IBOutlet weak var number13Label: UIButton!
  @IBOutlet weak var number17Label: UIButton!
  @IBOutlet weak var number19Label: UIButton!
  @IBOutlet weak var number23Label: UIButton!
  
  var numberButtons = [2, 3, 5, 7, 11, 13, 17, 19, 23]
  
  var displayNumber = 1
  var randomNumber = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    reset()
  }
  
  func reset() {
    displayNumber = 1
    
    for number in numberButtons {
      randomNumber = getRandomNumber()
      if randomNumber != 0 {
        displayNumber *= number * randomNumber
        print(randomNumber)
      }
    }
    
    primeNumberLabel.text = String(displayNumber)
  }
  
  func getRandomNumber() -> Int {
    // 40 20 16 12 8 4
    let randomNumber = Int.random(in: 1 ... 100)
    
    if randomNumber >= 1 && randomNumber <= 40 {
      return 0
    } else if randomNumber >= 41 && randomNumber <= 60 {
      return 1
    } else if randomNumber >= 61 && randomNumber <= 76 {
      return 2
    } else if randomNumber >= 77 && randomNumber <= 88 {
      return 3
    } else if randomNumber >= 89 && randomNumber <= 96 {
      return 4
    } else {
      return 5
    }
  }
  
  @IBAction func resetButtonAction(_ sender: Any) {
    reset()
  }
  


}

