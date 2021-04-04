//
//  SomeQuestionsCourseViewController.swift
//  DivisionPrimeNumber
//
//  Created by Maemura Ryo on 2021/03/30.
//

import UIKit

class SomeQuestionsCourseViewController: UIViewController {

  @IBOutlet weak var primeNumberLabel: UILabel!
  @IBOutlet weak var commentLabel: UILabel!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var resetButton: UIButton!
  @IBOutlet weak var timerLabel: UILabel!
  
  // タイマー
  var timer: Timer!
  // タイム
  var time = 0.00
  
  // 使用するボタンの数字
  var numberButtons = [2, 3, 5, 7, 11, 13, 17, 19, 23]
  
  // 表示される数字
  var displayNumber = 1
  // 乱数
  var randomNumber = 0
  
  // ゲームクリアするスコア
  var goalScoreNumber = 0
  // 現在のスコア
  var scoreNumber = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    goalScoreNumber = 5
    scoreLabel.text = String(scoreNumber) + "/" + String(goalScoreNumber)
    commentLabel.text = ""
    reset()
    startTimer()
  }
  
  // 表示をリセット
  func reset() {
    displayNumber = 1

    while displayNumber == 1 {
      for number in numberButtons {
        randomNumber = getRandomNumber()
        if randomNumber != 0 {
          displayNumber *= number * randomNumber
        }
      }
    }
    
    addComment(text: "リセットしました")
    primeNumberLabel.text = String(displayNumber)
  }
  
  // 乱数を取得
  func getRandomNumber() -> Int {
    // 60% : 0
    // 12% : 1
    // 10% : 2
    // 08% : 3
    // 06% : 4
    // 04% : 5
    let randomNumber = Int.random(in: 1 ... 100)
    
    if randomNumber >= 1 && randomNumber <= 60 {
      return 0
    } else if randomNumber >= 61 && randomNumber <= 72 {
      return 1
    } else if randomNumber >= 73 && randomNumber <= 82 {
      return 2
    } else if randomNumber >= 83 && randomNumber <= 90 {
      return 3
    } else if randomNumber >= 91 && randomNumber <= 96 {
      return 4
    } else {
      return 5
    }
  }
  
  // リセットボタン
  @IBAction func resetButtonAction(_ sender: Any) {
    reset()
  }
  
  // 数字ボタンアクション
  @IBAction func numberButtonAction(_ sender: UIButton) {
    print(sender.tag)
    divisionNumber(number: sender.tag)
  }
  
  // 割り算を実行
  func divisionNumber(number: Int) {
    if displayNumber % number == 0 {
      displayNumber /= number
      primeNumberLabel.text = String(displayNumber)
      if displayNumber == 1 {
        self.scoreDisplay()
      }
    } else {
      addComment(text: "その数では割れません")
    }
  }
  
  // スコア更新
  func scoreDisplay() {
    scoreNumber += 1
    resetButton.isEnabled = false
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [self] in
      if scoreNumber == goalScoreNumber {
        scoreLabel.text = "GAME CLEAR"
        timer.invalidate()
      } else {
        resetButton.isEnabled = true
        reset()
        scoreLabel.text = String(scoreNumber) + "/" + String(goalScoreNumber)
      }
    }
  }
  
  // コメントを表示する
  func addComment(text: String) {
    commentLabel.text = text
    
    // 2秒後に消去する
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      self.commentLabel.text = ""
    }
  }
  
  // 戻るボタン
  @IBAction func backScreenButtonAction(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
  
  // タイマースタート
  func startTimer() {
    timer = Timer.scheduledTimer(
      timeInterval: 0.01,
      target: self,
      selector: #selector(self.timerCounter),
      userInfo: nil,
      repeats: true
    )
  }

  // タイマー更新
  @objc func timerCounter() {
    time += 0.01
    timerLabel.text = String(floor(time * 10) / 10)
  }
  
}
