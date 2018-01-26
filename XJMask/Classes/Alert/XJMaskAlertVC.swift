//
//  XJMaskAlertVC.swift
//  蒙版层组件
//
//  Created by 李胜兵 on 2017/10/22.
//  Copyright © 2017年 shanlin. All rights reserved.
//

import UIKit

class XJMaskAlertVC: UIViewController {

    fileprivate var style: XJMaskStyle!
    fileprivate  var alertView: XJMaskAlertView!
    fileprivate lazy var popoverAnim: XJPopoverAnimator = XJPopoverAnimator { [weak self] (isPresented) in
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(style: XJMaskStyle) {
        super.init(nibName: nil, bundle: nil)
        self.style = style
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        //print("deinit----\(self.classForCoder)")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        alertView.frame = CGRect(x: 0, y: 0, width: style.presentedFrame.width, height: style.presentedFrame.height)
    }
}

extension XJMaskAlertVC: XJPopoverAnimatorable {
    
    fileprivate func setupUI() {
        willBecomeTransitioningDelegate(popoverAnim: popoverAnim, style: style)
       
        alertView = XJMaskAlertView(frame: CGRect.zero, style: style)
        view.addSubview(alertView)  
    }
    
    func btnClick(leftClickCallBack: @escaping(_ leftBtn: UIButton) -> (), rightClickCallBack: @escaping(_ rightBtn: UIButton) -> ()) {
        alertView.btnClick(leftClickCallBack: leftClickCallBack, rightClickCallBack: rightClickCallBack)
    }
}
