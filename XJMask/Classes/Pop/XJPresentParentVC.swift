//
//  XJPresentParentVC.swift
//  蒙版层组件
//
//  Created by 李胜兵 on 2017/10/20.
//  Copyright © 2017年 shanlin. All rights reserved.

/*
 1: presentedView?.superview?.frame 控制 presentedView?.frame
 2: presentedView?.frame控制内容区域层
 
 3: containerView：默认是整屏幕宽度和高度
 4: coverView的frame设置一定要和presentedView的基点一致，也就是说，虽然是insertcontainerView上，但是原点还是跟presentedView?.superview?为原点
 5: containerView修改位置都是没有什么作用、它不作为基点参考
 6: 修改presentedView?.superview?.frame尺寸会直接修改containerView的尺寸
*/

/*
 1: 在接收通知的时候记得移除通知
 
 */

import UIKit

class XJPresentParentVC: UIPresentationController {

    // MARK: - 对外属性
    var style: XJMaskStyle!
    
    // MARK: - 懒加载
    fileprivate lazy var coverView: UIView = UIView()
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        setupUI()
        NotificationCenter.default.addObserver(self, selector: #selector(tapClick), name: NSNotification.Name(rawValue: "XJMaskVCWillClose"), object: nil)
    }
    
    deinit {
        //print("deinit---\(self.classForCoder)")
        NotificationCenter.default.removeObserver(self)
    }
}

extension XJPresentParentVC {
    fileprivate func setupUI() {
        
        if style.isHiddenPresented {
            /// 如果蒙层隐藏：默认底部背景区域等于内容显示区域
            presentedView?.superview?.frame = CGRect(x: style.presentedFrame.origin.x, y: style.presentedFrame.origin.y , width: style.presentedFrame.width , height: style.presentedFrame.height)
        }else {
            /// 如果蒙层不隐藏: 默认为全屏幕（宽度和高度）
            presentedView?.superview?.frame = style.presentedMaskFrame == UIApplication.shared.keyWindow?.frame ? containerView!.frame : CGRect(x: 0, y: style.presentedMaskFrame.origin.y, width: UIScreen.main.bounds.width, height: style.presentedMaskFrame.height)
        }
        
        let y = style.presentedFrame.origin.y  - (UIScreen.main.bounds.height - style.presentedMaskFrame.height)
        let newPresentFrame = style.presentedMaskFrame == UIApplication.shared.keyWindow?.frame ? style.presentedFrame : CGRect(x: style.presentedFrame.origin.x, y: y, width: style.presentedFrame.width , height: style.presentedFrame.height)
        presentedView?.frame = style.isHiddenPresented ? CGRect(x: 0, y: 0, width: style.presentedFrame.width, height: style.presentedFrame.height) : newPresentFrame
        
        containerView?.insertSubview(coverView, at: 0)
        coverView.frame = style.isHiddenPresented ? CGRect(x: 0, y: 0, width: style.presentedFrame.width, height: style.presentedFrame.height) : containerView!.bounds
        coverView.backgroundColor = style.isHiddenPresented ? UIColor.clear : style.presentBackgroundColor.withAlphaComponent(style.presentAlpha)
        //print("coverView=\(coverView.frame)\npresentedView=\(presentedView!.frame)\ncontainerView=\(containerView!.frame)\npresentedView?.superview=\(presentedView!.superview!.frame)")
        
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(tapClick))
        coverView.addGestureRecognizer(tapGes)
        tapGes.isEnabled = style.isCanPresentClose
    }
}

extension XJPresentParentVC {
    @objc fileprivate func tapClick() {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}
