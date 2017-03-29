# HFAlertController 

> HFAlertController是对UIAlertController做的简单封装，将原生方法以常用的方式开放，简化弹窗的过程，并且支持背景点击取消（HFAlertController就是为了背景点击取消而生的），目前仅开发Swift3.0版本，如有需要Swift2.2版可联系我获取，谢谢大家支持！

##一、环境支持
* Xcode 8 或 更高
* iOS 8 或 更高
* 支持Swift3.0

##二、使用

**1.直接弹出默认弹框或底部弹框**

默认弹窗

``` swift
HFAlertController.showAlertController(controller: self, title: "标题", message: "内容", yesCallBack: nil)
```
底部弹窗

``` swift
HFAlertController.showSheetAlertController(controller: self, title: "标题", message: "内容", yesCallBack: nil)
```

**2.快速创建一个HFAlertController并进行手动弹出**

创建默认弹窗
	
```swift
let alertController = HFAlertController.alertController(title: "标题", message: "内容", yesCallBack: nil)
self.present(alertController, animated: true, completion: nil)
```

创建确认按钮自定义的弹窗

```swift
let alertController = HFAlertController.alertController(title: "标题", message: "内容", yesBtnTitle: String, yesCallBack: nil)
self.present(alertController, animated: true, completion: nil)
```

创建没有取消按钮的弹窗

``` swift
let alertController = HFAlertController.oneBtnAlertController(title: "标题", message: "内容", yesCallBack: nil)
self.present(alertController, animated: true, completion: nil)
```
**2.使用原生方式自定义**

``` swift
let alertController = HFAlertController(title: title, message: message, preferredStyle: preferredStyle)
let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
let yesAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.default) { (_) in
    // 确定按钮的回调
}
alertController.addAction(yesAction)
alertController.addAction(cancelAction)
self.present(alertController, animated: true, completion: nil)
```

