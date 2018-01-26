//
//  XJMaskVC.swift
//  蒙版层组件
//
//  Created by shanlin on 2017/10/20.
//  Copyright © 2017年 shanlin. All rights reserved.
//

import UIKit

public class XJMaskVC: UIViewController {

    fileprivate var style: XJMaskStyle!
    fileprivate var childView: UIView!
    public typealias XJMaskVCPresentedStatus = (_ isPresented: Bool) -> ()
    public var isPresentedCallback: XJMaskVCPresentedStatus?
    
    fileprivate lazy var popoverAnim: XJPopoverAnimator = XJPopoverAnimator { [weak self] (isPresented) in
        if self?.isPresentedCallback != nil {
            self?.isPresentedCallback!(isPresented)
        }
    }
    
    public init(style: XJMaskStyle, childView: UIView) {
        super.init(nibName: nil, bundle: nil)
        self.style = style
        self.childView = childView
        setupUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        //print("deinit----\(self.classForCoder)")
    }
    
    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        childView.frame = CGRect(x: 0, y: 0, width: style.presentedFrame.width, height: style.presentedFrame.height)
    }
}

extension XJMaskVC: XJPopoverAnimatorable {
    fileprivate func setupUI() {
        willBecomeTransitioningDelegate(popoverAnim: popoverAnim, style: style)
        view.addSubview(childView)
    }
}

