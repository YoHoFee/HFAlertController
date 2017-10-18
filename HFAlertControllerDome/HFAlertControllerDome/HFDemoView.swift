//
//  HFDemoView.swift
//  HFAlertControllerDome
//
//  Created by 姚鸿飞 on 2017/10/18.
//  Copyright © 2017年 姚鸿飞. All rights reserved.
//

import UIKit

class HFDemoView: UIView {


    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var label: UILabel!
    
    var exitBlock: (() -> Void)?
    
    class func newInstans(frame: CGRect) -> HFDemoView {
        let view: HFDemoView = Bundle.main.loadNibNamed("HFDemoView", owner: self, options: nil)?.last as! HFDemoView
        view.frame = frame
        return view
    }

    
    @IBAction func backButtonClickCallBack(_ sender: UIButton) {
        
        if self.exitBlock != nil {
            self.exitBlock!()
        }
        
    }
    
}
