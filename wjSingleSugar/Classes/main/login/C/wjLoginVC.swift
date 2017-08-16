//
//  wjLoginVC.swift
//  wjSingleSugar
//
//  Created by jerry on 2017/8/16.
//  Copyright © 2017年 wangjun. All rights reserved.
//

import UIKit

class wjLoginVC: wjMainBaseVC {

    @IBOutlet weak var telephoneNumberTF : UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var forgetPasswordBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wjNavigatonSettings()
    }
    
    func wjNavigatonSettings() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(self.wjCancelAction))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(self.wjRigesterAction))
    }
    
    
    func wjCancelAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func wjRigesterAction() {
        
    }
    
    @IBAction func wjLoginAction(_ sender: UIButton) {
    }

    @IBAction func wjForgetPasswordAction(_ sender: UIButton) {
    }

    @IBAction func wjThirdAppLoginClickAction(_ sender: UIButton) {
    }
    


}
