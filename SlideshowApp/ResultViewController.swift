//
//  ResultViewController.swift
//  SlideshowApp
//
//  Created by hirotaka.iwasaki on 2020/01/01.
//  Copyright © 2020 hirotaka.iwasaki. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    let image0:UIImage = UIImage(named:"sports_marathon_black_man")!
    let image1:UIImage = UIImage(named:"sports_marathon_man")!
    let image2:UIImage = UIImage(named:"sports_marathon_white_man")!
    
    var imageArray:[UIImage]! //参考：Lesson3.8.2
    
    // 受け取るためのプロパティ（変数）を宣言しておく
    var currentImageNum:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        imageArray = [image0, image1, image2]
        imageView.image = imageArray[currentImageNum]
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
