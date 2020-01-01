//
//  ViewController.swift
//  SlideshowApp
//
//  Created by hirotaka.iwasaki on 2020/01/01.
//  Copyright © 2020 hirotaka.iwasaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //@IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var goButtonAppearance: UIButton!
    @IBOutlet weak var backButtonAppearance: UIButton!
    @IBOutlet weak var playButtonAppearance: UIButton!
    @IBOutlet weak var buttonAsView: UIButton!
    
    let image0:UIImage = UIImage(named:"sports_marathon_black_man")!
    let image1:UIImage = UIImage(named:"sports_marathon_man")!
    let image2:UIImage = UIImage(named:"sports_marathon_white_man")!
    //let imageArray:[UIImage] = [image0, image1, image2]
    
    let totalImageNum:Int = 3
    var imageArray:[UIImage]! //参考：Lesson3.8.2
    
    var currentImageNum:Int = 0
    
    // タイマー
    var timer: Timer!
    
    //var resultViewController:ResultViewController!
    var resultViewController:ResultViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        goButtonAppearance.setTitleColor(UIColor.blue, for: .normal)
        backButtonAppearance.setTitleColor(UIColor.blue, for: .normal)
        playButtonAppearance.setTitleColor(UIColor.blue, for: .normal)
        
        self.timer = nil // timer == nil で判断するために、 timer = nil としておく
        
        imageArray = [image0, image1, image2]
        //imageArray.append(image0)
        
        buttonAsView.imageView?.contentMode = .scaleAspectFit // 参考：https://qiita.com/touyoubuntu/items/4fdad9d7b6c6eb5cdccf
        buttonAsView.contentHorizontalAlignment = .fill
        buttonAsView.contentVerticalAlignment = .fill
        
        //imageView.image = imageArray[currentImageNum]
        buttonAsView.setImage(imageArray[currentImageNum], for: .normal)
    }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
        // 必要なのか不明＞＞＞
        if self.timer != nil { // 安全のため
            self.timer.invalidate()   // タイマーを停止する
        }
        self.timer = nil          // timer == nil で判断するために、 timer = nil としておく
        goButtonAppearance.isEnabled = true
        backButtonAppearance.isEnabled = true
        goButtonAppearance.setTitleColor(UIColor.blue, for: .normal)
        backButtonAppearance.setTitleColor(UIColor.blue, for: .normal)
        playButtonAppearance.setTitle("再生", for: .normal)
        // 必要なのか不明＜＜＜
        
        // segueから遷移先のResultViewControllerを取得する
        //let resultViewController:ResultViewController = segue.destination as! ResultViewController // エラー
        
        //self.currentImageNum = resultViewController.currentImageNum
        self.currentImageNum = self.resultViewController.currentImageNum
        //imageView.image = imageArray[self.currentImageNum]
        buttonAsView.setImage(imageArray[self.currentImageNum], for: .normal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if self.timer != nil { // 必要なのか不明
            self.timer.invalidate()   // タイマーを停止する
            self.timer = nil          // playButton() の timer == nil で判断するために、 timer = nil としておく
            goButtonAppearance.isEnabled = true
            backButtonAppearance.isEnabled = true
            goButtonAppearance.setTitleColor(UIColor.blue, for: .normal)
            backButtonAppearance.setTitleColor(UIColor.blue, for: .normal)
            playButtonAppearance.setTitle("再生", for: .normal)
        }
        
        // segueから遷移先のResultViewControllerを取得する
        //let resultViewController:ResultViewController = segue.destination as! ResultViewController
        self.resultViewController = segue.destination as! ResultViewController
        
        resultViewController.currentImageNum = currentImageNum
    }
    
    
    
    // selector: #selector(updatetimer(_:)) で指定された関数
    // timeInterval: 2, repeats: true で指定された通り、0.1秒毎に呼び出され続ける
    @objc func updateTimer(_ timer: Timer) {
        self.currentImageNum = (self.currentImageNum + 1) % totalImageNum
        //print("testn03 \(self.currentImageNum)")
        //imageView.image = imageArray[self.currentImageNum]
        buttonAsView.setImage(imageArray[self.currentImageNum], for: .normal)
    }
    
    
    
    @IBAction func goButton(_ sender: Any) {
        //print("testn11")
        if self.timer == nil { // 安全のため
            self.currentImageNum = (self.currentImageNum + 1) % totalImageNum
            //print("testn01 \(self.currentImageNum)")
            //imageView.image = imageArray[self.currentImageNum]
            buttonAsView.setImage(imageArray[self.currentImageNum], for: .normal)
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        if self.timer == nil { // 安全のため
            //self.currentImageNum = (self.currentImageNum - 1) % 3 // ダメ // 参考：https://blog.ikappio.com/negative-numbers-are-returned-by-negative-number-residue-operation-in-swift/　『Swift3 負の数の剰余演算で負の数が返ってくるのは仕様』
            //print("testn02 \(self.currentImageNum)")
            let num = self.currentImageNum
            self.currentImageNum = (((num - 1) % totalImageNum) >= 0) ? ((num - 1) % totalImageNum) : (((num - 1) % totalImageNum) + totalImageNum) // 三項演算子
            //imageView.image = imageArray[self.currentImageNum]
            buttonAsView.setImage(imageArray[self.currentImageNum], for: .normal)
        }
    }
    
    @IBAction func playButton(_ sender: Any) {
        if self.timer == nil { // 停止中に押される
            self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(updateTimer(_:)), userInfo: nil, repeats: true)
            goButtonAppearance.isEnabled = false
            backButtonAppearance.isEnabled = false
            goButtonAppearance.setTitleColor(UIColor.gray, for: .normal)
            backButtonAppearance.setTitleColor(UIColor.gray, for: .normal)
            playButtonAppearance.setTitle("停止", for: .normal)
            
        }
        else { // 再生中に押される
            self.timer.invalidate()   // タイマーを停止する
            self.timer = nil          // playButton() の timer == nil で判断するために、 timer = nil としておく
            goButtonAppearance.isEnabled = true
            backButtonAppearance.isEnabled = true
            goButtonAppearance.setTitleColor(UIColor.blue, for: .normal)
            backButtonAppearance.setTitleColor(UIColor.blue, for: .normal)
            playButtonAppearance.setTitle("再生", for: .normal)
        }
    }
    
}

