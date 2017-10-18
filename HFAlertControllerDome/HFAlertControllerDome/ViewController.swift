//
//  ViewController.swift
//  HFAlertControllerDome
//
//  Created by 姚鸿飞 on 2017/3/29.
//  Copyright © 2017年 姚鸿飞. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    let tableViewTitles: [String] = ["默认弹窗","底部弹窗","仅确认按钮弹窗","账户输入弹框","自定义弹窗","自定义底部弹窗","仅确认自定义底部弹窗"]
    let Identifier = "Identifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: Identifier)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.titleView.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.titleView.layer.shadowColor = UIColor.lightGray.cgColor
        self.titleView.layer.shadowRadius = 10
        self.titleView.layer.shadowOpacity = 1
        self.tableView.rowHeight = 55
        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier, for: indexPath)
        for view in cell.contentView.subviews { view.removeFromSuperview() }
        if indexPath.row % 2 == 0 {
            cell.contentView.backgroundColor = UIColor.groupTableViewBackground
        }else {
            cell.contentView.backgroundColor = UIColor.white
        }
        cell.textLabel?.text = self.tableViewTitles[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        if indexPath.row == 6 {
            let line = UIView(frame: CGRect.init(x: 0, y: 55, width: tableView.frame.size.width, height: 1))
            line.backgroundColor = UIColor.groupTableViewBackground
            cell.contentView.addSubview(line)
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        switch indexPath.row {
        case 0:
            HFAlertController.showAlert(title: "标题", message: "点击背景可取消弹窗", ConfirmCallBack: nil)
        case 1:
            HFAlertController.showAlert(type: .ActionSheet, title: "标题", message: "点击背景可取消弹窗", ConfirmCallBack: nil)
        case 2:
            HFAlertController.showAlert(type: .OnlyConfirm, title: "标题", message: "无取消按钮弹窗不可点击背景取消", ConfirmCallBack: nil)
        case 3:
            HFAlertController.showAlert(type: .AccountAction, title: "标题", message: "这是内容", ConfirmCallBack: { (account, password) in
                print("用户输入了账号：" + account! + "\n用户输入了密码：" + password!)
            })
        case 4:
            let view = HFDemoView.newInstans(frame: CGRect.init(x: 0, y: 0, width: 280, height: 130))
            HFAlertController.showCustomView(view: view)
        case 5:
            let view = HFDemoView.newInstans(frame: CGRect.init(x: 0, y: 0, width: 355, height: 200))
            HFAlertController.showCustomView(view: view, type: .ActionSheet)
        case 6:
            let view = HFDemoView.newInstans(frame: CGRect.init(x: 0, y: 0, width: 280, height: 130))
            view.backButton.isHidden = false
            view.label.text = "不可点击背景取消，请创建一个按钮并调用返回的闭包进行关闭"
            view.exitBlock = HFAlertController.showCustomView(view: view, type: .OnlyConfirm)
        default: break
        }
    }

    
    
}


