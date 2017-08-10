//
//  RegisterViewController.swift
//  WhiteboardOnline
//
//  Created by hyrorre on 2017/08/10.
//  Copyright © 2017年 Moto Shinriki. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

	@IBOutlet weak var emailTextField: UITextField!
	
	@IBOutlet weak var passwordTextField: UITextField!
	
	@IBOutlet weak var retypeTextField: UITextField!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	
	@IBAction func registerDidTap(_ sender: Any) {
		ApiManager.register(email: (emailTextField.text!), password: (passwordTextField.text!), passwordConfirmation: (retypeTextField.text!))
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
