//
//  XJPopoverAnimatorable.swift
//  蒙版层组件
//
//  Created by 李胜兵 on 2017/10/22.
//  Copyright © 2017年 shanlin. All rights reserved.
//  1:XJPopoverAnimatorable 所有控制器对它的面向协议的遵守
//  2:在接收通知的时候记得移除通知 

import UIKit

public protocol XJPopoverAnimatorable {
    
}

extension XJPopoverAnimatorable where Self: UIViewController {
    
    /// 准备成为专场代理
    public func willBecomeTransitioningDelegate(popoverAnim: XJPopoverAnimator, style: XJMaskStyle) {
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = popoverAnim
        popoverAnim.style = style
        view.layer.cornerRadius = style.presentedCornerRadius
        view.layer.masksToBounds = true
    }
    
    /// 准备关闭蒙层 
    public func willCloseMask() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "XJMaskVCWillClose"), object: nil)
    }
}

extension XJPopoverAnimatorable where Self: UIView {
    /// 准备关闭蒙层
    public func willCloseMask() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "XJMaskVCWillClose"), object: nil)
    }
}
