//
//  wjRegisterVC.swift
//  wjSingleSugar
//
//  Created by gouzi on 2017/8/16.
//  Copyright © 2017年 wangjun. All rights reserved.
//

import UIKit
import SVProgressHUD

class wjRegisterVC: wjMainBaseVC {

    
    @IBOutlet weak var wjPhoneNumberTF: UITextField!
    
    @IBOutlet weak var wjGetVerifycodeBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wjPhoneNumberTF.becomeFirstResponder()
    }

    @IBAction func wjDidRegisterAction(_ sender: UIButton) {
        view.endEditing(true)
        if wjPhoneNumberTF.text?.characters.count != 0 {
            let alert = UIAlertController(title: "注册成功", message: "初始密码为 : 123456", preferredStyle: .alert)
            let action = UIAlertAction(title: "确定", style: .default, handler: { (action) in
                UserDefaults.standard.set(self.wjPhoneNumberTF.text, forKey: wjUserTelephone)
                UserDefaults.standard.set("123456", forKey: wjPassword)
                UserDefaults.standard.set(true, forKey: isLogin)
                SVProgressHUD.showInfo(withStatus: "注册成功!")
                let delayQueue = DispatchQueue(label: "com.wjSingleSugar.delayqueue", qos: .userInitiated)
                delayQueue.asyncAfter(deadline: .now() + 0.5, execute: {
                    SVProgressHUD.dismiss()
                    self.dismiss(animated: true, completion: nil)
                })
            })
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
 
}
