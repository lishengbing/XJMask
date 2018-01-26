//
//  XJMaskAlertVCable.swift
//  蒙版层组件
//
//  Created by 李胜兵 on 2017/10/22.
//  Copyright © 2017年 shanlin. All rights reserved.
//


import UIKit


//public enum XJAlertControllerStyle : Int {
//    case actionSheetStyle
//    case alertStyle
//}

public protocol XJMaskAlertVCable {
    
}

extension XJMaskAlertVCable where Self: UIViewController {
   public func XJ_presentAlertViewController(style: XJMaskStyle, _ leftDoneCallback: @escaping(_ handler: UIButton) -> (), rightDoneCallBack: @escaping(_ handler: UIButton) -> ()) {
        let p = XJMaskAlertVC(style: style)
        p.btnClick(leftClickCallBack: leftDoneCallback, rightClickCallBack: rightDoneCallBack)
        self.present(p, animated: true, completion: nil)
    }
}

extension XJMaskAlertVCable where Self: UIView {
   public func XJ_presentAlertViewController(style: XJMaskStyle, _ leftDoneCallback: @escaping(_ handler: UIButton) -> (), rightDoneCallBack: @escaping(_ handler: UIButton) -> ()) {
        let p = XJMaskAlertVC(style: style)
        p.btnClick(leftClickCallBack: leftDoneCallback, rightClickCallBack: rightDoneCallBack)
        Self.XJ_viewController(inView: self)?.present(p, animated: true, completion: nil)
    }
    
   public static func XJ_viewController(inView: UIView) -> UIViewController? {
        var nextVC = inView.next
        while(nextVC != nil) {
            if (nextVC?.isKind(of: UIViewController.self))! {
                return nextVC as? UIViewController
            }
            nextVC = nextVC?.next
        }
        return nil;
    }
}

extension XJMaskAlertVCable where Self: NSObject {
   public func XJ_presentAlertViewController(presentVC: UIViewController, style: XJMaskStyle, _ leftDoneCallback: @escaping(_ handler: UIButton) -> (), rightDoneCallBack: @escaping(_ handler: UIButton) -> ()) {
        let p = XJMaskAlertVC(style: style)
        p.btnClick(leftClickCallBack: leftDoneCallback, rightClickCallBack: rightDoneCallBack)
        assert(UIApplication.shared.keyWindow?.rootViewController != nil, "请检查一下你的根控制器是不是启动的时候没有设置！")
        presentVC.present(p, animated: true, completion: nil)
    }
}

