//
//  CreateCardViewController.swift
//  WhiteboardOnline
//
//  Created by Moto Shinriki on 2017/08/10.
//  Copyright © 2017年 Moto Shinriki. All rights reserved.
//

import UIKit

class CreateCardViewController: UIViewController {

    @IBOutlet weak var TextView: UITextView!
    @IBOutlet weak var TextView2: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // 枠のカラー
        TextView.layer.borderColor = UIColor.black.cgColor
        TextView2.layer.borderColor = UIColor.black.cgColor
        
        // 枠の幅
        TextView.layer.borderWidth = 1.0
        TextView2.layer.borderWidth = 1.0
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
