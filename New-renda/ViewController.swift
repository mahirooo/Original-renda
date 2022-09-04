//
//  ViewController.swift
//  renda-battle
//
//  Created by 長崎茉優 on 2022/08/29.
//

import UIKit
import Firebase
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet var countLabel: UILabel!
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var redBack: UIView!
    @IBOutlet var blueBack: UIView!
    
    var count = 10
    var bluex = 0
    
    var time = 15
    var timer = Timer()
    
    let firestore = Firestore.firestore()
//    let tapSound = try!AVAudioPlayer(data: NSDataAsset(name: "sound")!.data)

    // Do any additional setup after loading the view.
    
    override var shouldAutorotate: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hantei()
       countLabel.layer.cornerRadius = 105.0
        
        firestore.collection("counts").document("share").addSnapshotListener { snapshot, error in
                    if error != nil {
                        print("エラーが発生しました")
                        print("error")
                        return
                    }
                    let data = snapshot?.data()
                    if data == nil {
                        print("データがありません")
                        return
                    }
                    let count = data!["count"] as? Int
                    if count == nil {
                        print("countという対応する値がありません")
                        return
                    }
                    self.count = count!
                    self.countLabel.text = String(count!)
                }
        
        firestore.collection("times").document("share").addSnapshotListener { snapshot, error in
                    if error != nil {
                        print("エラーが発生しました")
                        print("error")
                        return
                    }
                    let data = snapshot?.data()
                    if data == nil {
                        print("データがありません")
                        return
                    }
                    let time = data!["time"] as? Int
                    if time == nil {
                        print("timeという対応する値がありません")
                        return
                    }
                    self.time = time!
                    self.timerLabel.text = String(time!)
                }
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [self] (timer) in
            self.time -= 1
            self.timerLabel.text = String(self.time)
            self.self.firestore.collection("counts").document("share").setData(["time": self.time])
            
            if self.time == 0 {
                            self.performSegue(withIdentifier: "next", sender: nil)
                        }
            
        })
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            timer.invalidate()
        if segue.identifier == "next" {
         
                    // ③遷移先ViewCntrollerの取得
                    let nextView = segue.destination as! finishViewController
         
                    // ④値の設定
            nextView.count = self.count
                }
        }
    
    func hantei(){
    if count > 10{
        countLabel.textColor = UIColor(red:0.99, green:0.227, blue:0.18, alpha:1.0)
    }
        if count < 10{
            countLabel.textColor = UIColor(red:0.0, green:0.58, blue:0.78, alpha:1.0)
        }
        if count == 10{
            countLabel.textColor = UIColor(red:0.156, green:0.156, blue:0.156, alpha:1.0)
        }
    }
    
    @IBAction func plus(){
        count += 1
        countLabel.text = String(count)
        firestore.collection("counts").document("share").setData(["count": count])
        if count > 10{
            self.view.sendSubviewToBack(blueBack)
        }
            blueBack.frame.size.width -= 15
        redBack.frame.size.width += 15
        bluex += 15
        blueBack.transform = CGAffineTransform(translationX: CGFloat(bluex), y: 0)
//        tapSound.currentTime = 0
//        tapSound.play()
        self.hantei()
    }
    
    @IBAction func minus(){
        count -= 1
        countLabel.text = String(count)
        firestore.collection("counts").document("share").setData(["count": count])
        if count < 10{
            self.view.sendSubviewToBack(redBack)
        }
        redBack.frame.size.width -= 15
        blueBack.frame.size.width += 15
        bluex -= 15
        blueBack.transform = CGAffineTransform(translationX: CGFloat(bluex), y: 0)
//        tapSound.currentTime = 0
//        tapSound.play()
        self.hantei()
    }
    
    


}


