//  ViewController.swift
//  Q and A
//  Created by Pincheng Huang on 2020/9/7.
//  Copyright © 2020 Pincheng. All rights reserved.
//

import UIKit
// import GameplayKit


class ViewController: UIViewController {
    
    @IBOutlet weak var temp: UILabel!
    
    
    // 設置元件 UI Label 以顯示目前為第幾問
    @IBOutlet weak var questionCount: UILabel!
    
    // 設置元件 UI Label 並連結 IBOutlet Questions ，以顯示題目
    @IBOutlet weak var Questions: UILabel!
    
    // 設置元件 UI Label 並連結 IBOutlet Answers ，以顯示解答
    @IBOutlet weak var Answers: UILabel!
    
    // 宣告一個類別，名為 Question，並在其中宣告兩個型別為字串的變數 description (存放題目) 跟 answer (存放解答)
    class Question {
        var description = ""
        var answer = ""
        
    }
    
    // 宣告變數 count 來計算題號 (第一題、第二題…)
    var count = 0
    // 變數 index 是用來計算使用者按了多少次 "下一題" ，以便在顯示十題之後結束遊戲
    var index = 0
    
    // 宣告變數 tempNumber 來暫存產出的亂數
    var tempNumber = Int()
    
 // 宣告變數 questionList，將 類別 Question 以陣列方式存入 (所有的題目與解答都會存放在 questionList 的陣列內)
    var questionList = [Question]()
    
 // 宣告變數 AnswersTemp ，當作解答的暫存區
    var AnswersTemp = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 在 viewDidLoad 先產出所有的題庫
        let q1 = Question() // 宣告常數，並存入 類別 Question
        q1.description = "烽火戲諸侯的典故，與中國歷史的哪位君王有關?" // 定義問題
        q1.answer = "周幽王" // 定義解答
        questionList.append(q1) // 把上兩行所定義的 q1 屬性存入 變數 questionList 的陣列之中
        
        let q2 = Question()
        q2.description = "哪一種蝙輻不具聲納系統?"
        q2.answer = "臺灣狐輻"
        questionList.append(q2)
        
        let q3 = Question()
        q3.description = "水螳螂的呼吸管位於身上的哪個部位?"
        q3.answer = "腹部末端"
        questionList.append(q3)
        
        let q4 = Question()
        q4.description = "雕蟲小技的「蟲」，代表什麼意思?"
        q4.answer = "字體"
        questionList.append(q4)
        
        let q5 = Question()
        q5.description = "中國歷史上，哪位皇帝生了最多兒女?"
        q5.answer = "據「開封府狀」統計，靖康之難時，宋徽宗的妃嬪共一百四十三位，子嗣共八十人"
        questionList.append(q5)
        
        let q6 = Question()
        q6.description = "「囍」這個字是誰發明的?"
        q6.answer = "王安石"
        questionList.append(q6)
        
        let q7 = Question()
        q7.description = "「楚河漢界」，位於中國哪個省份?"
        q7.answer = "河南省"
        questionList.append(q7)
        
        let q8 = Question()
        q8.description = "哪種植物同時被選為「四君子」，也是「歲寒三友」?"
        q8.answer = "竹子"
        questionList.append(q8)
        
        let q9 = Question()
        q9.description = "被害者對加害者產生情感的症狀，稱為什麼?"
        q9.answer = "斯德哥爾摩症候群"
        questionList.append(q9)
        
        let q10 = Question()
        q10.description = "地球上哪一個雕像擁有自已的衣櫃?"
        q10.answer = "比利時的尿尿小童"
        questionList.append(q10)
        
        
        // 宣告常數 randomNumber，用來亂數化開啟 app 後的第一題題目內容
        let i = 0...questionList.count - 1
        let randomNumber = i.randomElement()!
        tempNumber = randomNumber // 把在 viewDidLoad 產生的亂數，存成 View Controller 的 property ，才可以在後面沿用
        temp.text = "\(tempNumber)" // debug
        
        count = 1
        questionCount.text = "第 " + "\(count)" + " 問"
        Questions.text = questionList[randomNumber].description
        AnswersTemp = questionList[randomNumber].answer
        
    }
    
    

    // 設置元件 UI Button ，讓使用者點選後，可以看到解答
    @IBAction func getAnswer(_ sender: UIButton) {
        Answers.text = AnswersTemp
        
    }
    
    
    
    
    // 顯示下一個題目
    func goNextQuestion() {
                
        if index == 10 {
            index = 0
            gameOver()
            
        } else {
            
            // 宣告常數 randomNumber，用來亂數化開啟 app 後的第一題題目內容
            // let i = 0...questionList.count - 1
            // let randomNumber = i.randomElement()!
            tempNumber += 1
            temp.text = "\(tempNumber)" // debug
            
            if tempNumber < 10 {
                questionCount.text = "第 " + "\(count)" + " 問"
                Questions.text = questionList[tempNumber].description
                AnswersTemp = questionList[tempNumber].answer
            } else {
                tempNumber = 0
                questionCount.text = "第 " + "\(count)" + " 問"
                Questions.text = questionList[tempNumber].description
                AnswersTemp = questionList[tempNumber].answer
            }
        }
    }
    
    @IBAction func nextQuestion(_ sender: UIButton) {
        count += 1 // 計算 第幾問，以便顯示在 元件 UI Label (questionCount)
        index += 1 // 變數 index 是用來計算使用者按了多少次 "下一題" ，以便在顯示十題之後結束遊戲
        questionList.shuffle() // 亂數化題庫的排序
        goNextQuestion()
        Answers.text = "" // 清除 解答欄位

    }
    
    
    func gameOver() {
    
        
        // 設定遊戲結束的警告視窗，並顯示答案
        let gameOverAlert = UIAlertController(title: "Game Over", message: "已做答十題", preferredStyle: .alert)
        
        // 設定 再來一局 的功能
        let replay = UIAlertAction(title: "再來一次", style: .default, handler: {(action:UIAlertAction) -> () in
            self.viewDidLoad() // 呼叫 viewDidLoad，重開一局
            
            })
        
        //將 replay 加入進 Alert 中
        gameOverAlert.addAction(replay)
        self.present(gameOverAlert, animated: true, completion: nil)
        
        
    }

}

