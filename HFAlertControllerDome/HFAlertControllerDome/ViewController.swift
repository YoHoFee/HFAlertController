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
            HFAlertController.showAlert(title: "标题", message: "点击背景可取消弹窗", ConfirmCallBack: nil)
        case 1:
            HFAlertController.showAlert(type: .ActionSheet, title: "标题", message: "点击背景可取消弹窗", ConfirmCallBack: nil)
        case 2:
            HFAlertController.showAlert(type: .OnlyConfirm, title: "标题", message: "无取消按钮弹窗不可点击背景取消", ConfirmCallBack: nil)
        case 3:
            let view = UIView(frame: CGRect.init(x: 100, y: 100, width: 100, height: 100))
            view.backgroundColor = UIColor.blue
            HFAlertController.showCustomView(view: view)
        default: break
        
        }
        
        
    }
    
    

}

