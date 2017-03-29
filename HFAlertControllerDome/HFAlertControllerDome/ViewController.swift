//
//  ViewController.swift
//  HFAlertControllerDome
//
//  Created by 姚鸿飞 on 2017/3/29.
//  Copyright © 2017年 姚鸿飞. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func clickOnButton(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            HFAlertController.showAlertController(controller: self, title: "标题", message: "内容", yesCallBack: nil)
            break
        case 1:
            HFAlertController.showSheetAlertController(controller: self, title: "标题", message: "内容", yesCallBack: nil)
            break
        default: break
        
        }
        
        
    }

}

