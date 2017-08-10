//
//  CreateGroupViewController.swift
//  WhiteboardOnline
//
//  Created by Moto Shinriki on 2017/08/10.
//  Copyright © 2017年 Moto Shinriki. All rights reserved.
//

import UIKit

class CreateGroupViewController: UIViewController {
    
    @IBAction func unwindToTop(segue: UIStoryboardSegue){
        
    }
    
    let w = UIScreen.main.bounds.size.width
    let h = UIScreen.main.bounds.size.height
    
    @IBOutlet weak var fieldView: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var textFields = [UITextField]()
    
    @IBOutlet weak var stepper: UIStepper!

    @IBAction func stepperDidTap(_ sender: Any) {
        let count = Int(stepper.value)
        
        if (count > self.textFields.count) {
            let textField = UITextField(frame: CGRect(x:w / 2 - 150, y:314 + 35.0 * CGFloat(count), width:300.0, height:30.0))
            textField.layer.borderColor = UIColor.black.cgColor
            textField.layer.borderWidth = 1.0
            self.textFields.append(textField)
            scrollView.addSubview(textField)
            scrollView.contentSize.height = h + ((314 + 35.0 * CGFloat(count)) - h)
            scrollView.contentSize.width = w
        } else if (count < self.textFields.count) {
            guard let textField = self.textFields.last else {
                return
            }
            textField.removeFromSuperview()
            self.textFields.removeLast()
        }
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scrollView.delaysContentTouches = false;
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
