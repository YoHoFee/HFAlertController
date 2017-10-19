# HFAlertController 
**version 4.0.0**

> HFAlertController是对UIAlertController做的简单封装，将原生方法以常用的方式开放，简化弹窗的过程，秉承一句代码理念进行弹窗优化方便弹窗开发。4.0版本支持Swift4与iOS11，新增支持输入框弹窗、自定义View的弹出，并对内部方法进行重新封装优化和修饰，简化调用流程。

## 目录

* [1.环境要求](#1)
* [2.安装](#2)
* [3.使用](#3)
* [4.许可](#4)


<h2 id = "1">一、环境要求</h2>
* Xcode 8.1 或 更高
* iOS 8     或 更高
* Swift3.2  或 Swift4.0
* Objective-C

    
<h2 id = "2">二、安装</h2>

**将HFAlertController.swift文件拖入项目目录即可使用。**
**如果需要在Objective-C中使用，请点击[此处](http://some-url.com)查看设置方式，按步骤设置Xcode即可正常调用。**

<h2 id = "3">三、使用</h2>

**1.快速弹出默认弹框或底部弹框**

*** 系统弹窗

默认弹窗

``` swift
HFAlertController.showAlert(title: "标题", message: "内容", ConfirmCallBack: nil)
```
底部弹窗

``` swift
HFAlertController.showAlert(type: .ActionSheet, title: "标题", message: "内容", ConfirmCallBack: nil)
```
只可确认的弹窗（此种类型弹窗不可点击背景取消）

``` swift
HFAlertController.showAlert(type: .OnlyConfirm, title: "标题", message: "内容", ConfirmCallBack: nil)
```
账户输入弹窗

``` swift
HFAlertController.showAlert(type: .AccountAction, title: "标题", message: "内容", ConfirmCallBack: { (account, password) in
print("用户输入了账号：" + account! + "\n用户输入了密码：" + password!)
})
```

*** 自定义弹窗

默认弹窗
``` swift
let myView = UIView() // 需要弹出的自定义View
HFAlertController.showCustomView(view: myView)
```

底部弹窗

``` swift
let myView = UIView() // 需要弹出的自定义View
HFAlertController.showCustomView(view: myView, type: .ActionSheet)
```

只可确认的弹窗（此种类型弹窗不可点击背景取消）

``` swift
/*  此种弹窗不可点击背景取消，所以请确保自定义View中有预留
    取消按钮，该方法会返回取消的回调闭包，需要手动传入你预
    留的取消按钮点击事件中去调用
*/
let myView = UIView() // 需要弹出的自定义View
let exitBlock = HFAlertController.showCustomView(view: myView, type: .OnlyConfirm)

```


**2.快速创建一个HFAlertController系统类型弹窗并进行手动弹出**

创建默认弹窗
	
```swift
let alertController = HFAlertController.alertController(title: "标题", message: "内容", ConfirmCallBack: nil)
self.present(alertController, animated: true, completion: nil)
```

创建确认按钮自定义的弹窗

```swift
let alertController = HFAlertController.alertController(title: "标题", message: "内容", yesBtnTitle: String, ConfirmCallBack: nil)
self.present(alertController, animated: true, completion: nil)
```

创建没有取消按钮的弹窗

``` swift
let alertController = HFAlertController.alertControllerWithOnlyConfirm(title: "标题", message: "内容", ConfirmCallBack: nil)
self.present(alertController, animated: true, completion: nil)
```

创建带账户密码输入框的弹窗

``` swift
let alertController = HFAlertController.alertControllerWithAccount(title: "标题", message: "内容", ConfirmCallBack: { (account, password) in

    // 确认按钮回调，account为用户输入的账号，password为密码
    print("用户输入了账号：" + account! + "\n用户输入了密码：" + password!)
    
}
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

<h2 id = "4">四、许可</h2>

**此项目为开源项目，允许任何人免费使用并提出宝贵的意见，本项目仅限学习交流，不得用于商业用途，如因本项目引发任何损失，作者不承担任何法律责任。**



