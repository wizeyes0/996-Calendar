//
//  ICUStartViewController.swift
//  ICU996
//
//  Created by HanLiu on 2019/3/29.
//  Copyright © 2019 Harry Duan. All rights reserved.
//

import UIKit

class ICUStartViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var salaryTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.becomeFirstResponder()
    }

    @IBAction func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func done() {
        guard !(salaryTextField.text?.isEmpty)! else {
            let alertVc = UIAlertController(title: "不填薪水有什么意思...", message: "不填薪水有什么意思...", preferredStyle: .alert)
            alertVc.addAction(UIAlertAction(title: "好的好的", style: .default, handler: nil))
            self.present(alertVc, animated: true, completion: nil)

            return
        }
        // 已设置过薪水
        IcuCacheManager.get.hasSetSalary = true
        close()
    }
}

extension ICUStartViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            salaryTextField.becomeFirstResponder()
        }else if textField == salaryTextField {
            salaryTextField.resignFirstResponder()
        }
        
        return true
    }
}
