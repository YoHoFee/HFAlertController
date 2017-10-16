//
//  HFAlertController.swift
//  SmallTradePlatform
//
//  Created by 姚鸿飞 on 2016/12/20.
//  Copyright © 2016年 pmec. All rights reserved.
//

import UIKit


/// 弹窗类型枚举
///
/// - Default: 默认弹窗
/// - ActionSheet: 底部弹窗
/// - OnlyConfirm: 只可确认的默认弹窗
@objc enum HFAlertType: Int {
    
    case Default
    
    case ActionSheet
    
    case OnlyConfirm
    
}

/// 弹出动画枚举
///
/// - System: 仿系统弹出样式（默认）
/// - Elasticity: 弹力样式
@objc enum HFAlertAnimationOption: Int {
    
    case System
    
    case Elasticity
    
}

/// 对系统弹窗控制器进行封装，实现背景点击返回
class HFAlertController: UIAlertController, HFAlertBkViewDelegate {
    
    
    /// 当前显示的控制器
    fileprivate class var currentDisplayViewController: UIViewController? {
        get{ return HFAlertController.currentViewController() }
    }
    fileprivate var currentDisplayViewControllerCache: UIViewController?
    /// 底部蒙版
    fileprivate var newBottonView:  HFAlertBkView?
    /// 头部蒙版
    fileprivate var newTopView:     HFAlertBkView?
    /// 左边蒙版
    fileprivate var newLeftView:    HFAlertBkView?
    /// 右边蒙版
    fileprivate var newRightView:   HFAlertBkView?
    /// 是否允许取消
    fileprivate var isAllowedCancel: Bool = true
    
    

    
    /// 弹出自定义弹窗
    ///
    /// - Parameters:
    ///   - view: 需要弹出的View
    ///   - type: 提示框类型
    open class func showCustomView(view: UIView,type: HFAlertType? = .Default) {
        
        if let windouw = UIApplication.shared.keyWindow {
            
            let bkView = HFAlertBkView.fullBackground()
            bkView.addSubview(view)
            bkView.alpha = 0
            windouw.addSubview(bkView)
            HFAlertController.alertAnimation(view: view, animation: .System)
            UIView.animate(withDuration: 0.25, animations: {
                bkView.alpha = 1
            })
        }
        
    }
    
    
    /// 弹出默认提示框
    ///
    /// - Parameters:
    ///   - type: 提示框类型
    ///   - title: 提示框标题
    ///   - message: 提示框内容
    ///   - ConfirmCallBack: 完成回调
    @discardableResult
    open class func showAlert(type:HFAlertType? = .Default, title: String, message: String, ConfirmCallBack:(() -> Void)?) -> HFAlertController {
        
        var alertController: HFAlertController
        
        switch type! {
        case HFAlertType.Default:
            alertController = HFAlertController.alertController(title: title, message: message, ConfirmCallBack: ConfirmCallBack)
        case HFAlertType.ActionSheet:
            alertController = HFAlertController.alertController(title: title, message: message, preferredStyle: .actionSheet ,ConfirmCallBack: ConfirmCallBack)
        case HFAlertType.OnlyConfirm:
            alertController = HFAlertController.oneBtnAlertController(title: title, message: message, ConfirmCallBack: ConfirmCallBack)
        }
        
        if self.currentDisplayViewController != nil {
            self.currentDisplayViewController!.present(alertController, animated: true, completion: nil)
        }else {
            print("HFAlertController_ErrerMsg = ”当前没有可用的视图控制器可供弹出，请检查视图层级“")
        }
        
        return alertController
    }

    
    
    /// 创建一个默认的提示框
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - message: 内容文本
    ///   - preferredStyle: 提示框类型
    ///   - ConfirmCallBack: 确定按钮回调
    /// - Returns: 一个默认的提示框
    open class func alertController(title: String, message: String, preferredStyle: UIAlertControllerStyle = .alert, ConfirmCallBack:(() -> Void)?) -> HFAlertController {
        
        let alertController = HFAlertController(title: title, message: message, preferredStyle: preferredStyle)
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
        let yesAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.default) { (_) in
            if ConfirmCallBack != nil {
                ConfirmCallBack!()
            }
        }
        alertController.addAction(yesAction)
        alertController.addAction(cancelAction)
        
        return alertController
    }
    
    
    /// 自定义确定按钮文本的弹出窗
    ///
    /// - Parameters:
    ///   - title: 标题文本
    ///   - message: 弹窗内容
    ///   - yesBtnTitle: 确定按钮文本
    ///   - ConfirmCallBack: 确定按钮回调
    /// - Returns: return value description
    open class func alertController(title: String, message: String, yesBtnTitle: String, ConfirmCallBack:(() -> Void)?) -> HFAlertController {
        
        let alertController = HFAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
        let yesAction = UIAlertAction(title: yesBtnTitle, style: UIAlertActionStyle.default) { (_) in
            if ConfirmCallBack != nil {
                ConfirmCallBack!()
            }
        }
        alertController.addAction(yesAction)
        alertController.addAction(cancelAction)
        
        return alertController
    }
    
    
    /// 只有一个确定按钮的弹框（没有取消按钮）
    ///
    /// - Parameters:
    ///   - title: 标题文本
    ///   - message: 弹框内容
    ///   - ConfirmCallBack: 确定按钮回调
    /// - Returns: return value description
    open class func oneBtnAlertController(title: String, message: String, ConfirmCallBack:(() -> Void)?) -> HFAlertController {
        
        let alertController = HFAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let yesAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.default) { (_) in
            if ConfirmCallBack != nil {
                ConfirmCallBack!()
            }
        }
        alertController.addAction(yesAction)
        alertController.isAllowedCancel = false
        return alertController
    }
    
    
    /// 获取当前显示的控制器
    ///
    /// - Parameter base: 基控制器
    /// - Returns: 当前显示的控制器
    fileprivate class func currentViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return currentViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return currentViewController(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return currentViewController(base: presented)
        }
        return base
    }
    

    /// 仅在此方法中可获取AlertView的大小
    ///
    /// - Parameter animated: -
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        let windouw: UIWindow   = UIApplication.shared.keyWindow!
        let bkView: UIView      = (windouw.subviews.last)!
        self.layoutNewbackgroundView(bkView: bkView)
        
    }
    
    
    /// 布局与设置蒙版
    ///
    /// - Parameter bkView: 背景View
    fileprivate func layoutNewbackgroundView(bkView: UIView) {
        
        newBottonView   = HFAlertBkView(delegate: self)
        newTopView      = HFAlertBkView(delegate: self)
        newRightView    = HFAlertBkView(delegate: self)
        newLeftView     = HFAlertBkView(delegate: self)
        
        bkView.addSubview(newTopView!)
        bkView.addSubview(newBottonView!)
        bkView.addSubview(newLeftView!)
        bkView.addSubview(newRightView!)
        

        newBottonView!.frame     = CGRect.init(x: 0, y: self.view.frame.maxY, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-self.view.frame.maxY)
        newTopView!.frame        = CGRect(x:0, y:0, width: UIScreen.main.bounds.width, height: self.view.frame.origin.y)
        newLeftView!.frame       = CGRect(x:0, y:self.view.frame.origin.y,width: self.view.frame.origin.x, height:self.view.frame.size.height)
        newRightView!.frame      = CGRect(x:self.view.frame.maxX, y:self.view.frame.origin.y,width:UIScreen.main.bounds.width - self.view.frame.maxX,height: self.view.frame.size.height)
        
        
    }
    
    
    /// 添加弹窗动画
    ///
    /// - Parameters:
    ///   - view: 需要添加动画的View
    ///   - animation: 动画类型枚举
    fileprivate class func alertAnimation(view: UIView,animation: HFAlertAnimationOption) {
        
        let popAnimation: CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "transform")
        var values: [NSValue]
        var timingFunctions: [CAMediaTimingFunction]
        
        
        switch animation {
        case .System:
            values = [NSValue(caTransform3D: CATransform3DMakeScale(1.2, 1.2, 1.0)),
                      NSValue(caTransform3D: CATransform3DMakeScale(1.0, 1.0, 1.0)),
                      NSValue(caTransform3D: CATransform3DIdentity)]
            timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear),
                               CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)]
            
        case .Elasticity:
            values = [NSValue(caTransform3D: CATransform3DMakeScale(0.01, 0.01, 1.0)),
                      NSValue(caTransform3D: CATransform3DMakeScale(1.1, 1.1, 1.0)),
                      NSValue(caTransform3D: CATransform3DMakeScale(0.9, 0.9, 1.0)),
                      NSValue(caTransform3D: CATransform3DIdentity)]
            timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut),
                               CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut),
                               CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)]
        }
        
        popAnimation.duration        = 0.4
        popAnimation.values          = values
        popAnimation.keyTimes        = [0.0,0.5,0.75,1.0]
        popAnimation.timingFunctions = timingFunctions

        
        view.layer.add(popAnimation, forKey: nil)
    }
    
    
    /// 蒙版点击回调
    func touchCallBack() {
        if self.isAllowedCancel == true {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    
}

protocol HFAlertBkViewDelegate: class {
    func touchCallBack()
}

fileprivate class HFAlertBkView: UIView {
    
    fileprivate weak var bkViewDelegate: HFAlertBkViewDelegate?
    
    init(delegate: HFAlertBkViewDelegate?) {
        
        super.init(frame: CGRect.null)
        self.bkViewDelegate = delegate
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    fileprivate class func fullBackground() -> HFAlertBkView {
        
        let obj = HFAlertBkView(frame: UIScreen.main.bounds)
        obj.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.35)
        return obj
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.bkViewDelegate != nil {
            self.bkViewDelegate?.touchCallBack()
            self.removeFromSuperview()
        }else {
            UIView.animate(withDuration: 0.25, animations: {
                self.alpha = 0
            }, completion: { (_) in
                self.removeFromSuperview()
            })
        }
        
    }
    
    
}



