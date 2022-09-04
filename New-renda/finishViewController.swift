//
//  finishViewController.swift
//  renda-battle
//
//  Created by 長崎茉優 on 2022/08/29.
//

import UIKit

class finishViewController: UIViewController {

    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var pointLabel: UILabel!
    @IBOutlet var startButton: UIButton!
    @IBOutlet var gameButton: UIButton!
    var count = 0
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pointLabel.text = String(count)
        judge()
    }
    

    func judge(){
    if count > 10{
        view.backgroundColor = UIColor(red:0.99, green:0.227, blue:0.18, alpha:1.0)
        resultLabel.text = "Red Win!"
    }
        if count < 10{
            view.backgroundColor = UIColor(red:0.0, green:0.58, blue:0.78, alpha:1.0)
            resultLabel.text = "Blue Win!"
        }
        if count == 10{
            view.backgroundColor = UIColor(red:0.156, green:0.156, blue:0.156, alpha:1.0)
            resultLabel.text = "Draw..."
        }
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

