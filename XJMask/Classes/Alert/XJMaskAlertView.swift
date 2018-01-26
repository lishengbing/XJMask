//
//  XJMaskAlertView.swift
//  蒙版层组件
//
//  Created by 李胜兵 on 2017/10/22.
//  Copyright © 2017年 shanlin. All rights reserved.
//

import UIKit

class XJMaskAlertView: UIView {
    
    // MARK: - 定义属性
    fileprivate var style: XJMaskStyle!
    
    // MARK: - 懒加载
    fileprivate lazy var topBackgroudView: UIView = UIView()
    fileprivate lazy var titleLabel: UILabel = UILabel()
    fileprivate lazy var subTitleLabel: UILabel = UILabel()
    fileprivate lazy var leftBtn: UIButton = UIButton()
    fileprivate lazy var rightBtn: UIButton = UIButton()
    fileprivate lazy var horizontalLine: UIView = UIView()
    fileprivate lazy var verticalLine: UIView = UIView()
    
    typealias btnClickCallBack = (_ btn: UIButton) -> ()
    fileprivate var leftClickCallBack: btnClickCallBack?
    fileprivate var rightClickCallBack: btnClickCallBack?
    
    
    init(frame: CGRect, style: XJMaskStyle) {
        super.init(frame: frame)
        self.style = style
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        /// 如果两个按钮的高度等于整个弹窗的高度的1/3,则两个都可以使用，
        /// 如果不等于，优先使用twoBtnHeight这个属性为准: (style.presentedFrame.height / 3) * 2
        let titleLabelH: CGFloat = style.presentedFrame.height - style.twoBtnHeight
        
        /// 没有子标题的时候：默认居中显示主标题
        if style.subTitle.characters.count == 0 {
            topBackgroudView.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: titleLabelH)
            titleLabel.frame = CGRect(x: style.leftEdge, y: 0, width: topBackgroudView.bounds.width - 2 * style.leftEdge, height: topBackgroudView.bounds.height)
            titleLabel.center.x = topBackgroudView.center.x
        }else {
            // 0: 计算主标题的宽度和高度
            // swift 3.2: [NSFontAttributeName: fontSize]
            // swift 4.0: [NSAttributedStringKey.font: fontSize]
            // FIXME: 等swift5.0在适配吧？？？？？？？？？？
            let realMainLabelSize = titleLabel.text?.boundingRect(with: CGSize(width: self.bounds.width - 2 * style.leftEdge, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: style.mainTextFont], context: nil).size
            
            /// 一行主标题和一行子标题
            topBackgroudView.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: titleLabelH)
            titleLabel.frame = CGRect(x: style.leftEdge, y: style.mainTitleTopMargin, width: self.bounds.width - 2 * style.leftEdge, height: (realMainLabelSize?.height)!)
            titleLabel.center.x = self.center.x
            subTitleLabel.frame = CGRect(x: style.leftEdge, y: titleLabel.frame.maxY + style.subTitleToMainMargin, width: titleLabel.bounds.width, height: subTitleLabel.bounds.height)
        }
        horizontalLine.frame = CGRect(x: 0, y: topBackgroudView.frame.maxY + topBackgroudView.frame.origin.y, width: self.bounds.width, height: 0.5)
        verticalLine.frame = CGRect(x: 0, y: horizontalLine.frame.maxY, width: 0.5, height: self.bounds.height - horizontalLine.frame.maxY)
        verticalLine.center.x = self.center.x
        
        let w: CGFloat = (self.bounds.width - verticalLine.frame.width) * 0.5
        leftBtn.frame = CGRect(x: 0, y: verticalLine.frame.origin.y, width: w, height: verticalLine.frame.height)
        rightBtn.frame = CGRect(x: self.bounds.width - verticalLine.frame.maxX, y: verticalLine.frame.origin.y, width: w + 0.5, height: verticalLine.frame.height)
    }
}

extension XJMaskAlertView {
    fileprivate func setupUI() {
        
        topBackgroudView.backgroundColor = style.topBackgroundColor
        addSubview(topBackgroudView)
        
        titleLabel.text = style.mainTitle
        titleLabel.textAlignment = .center
        titleLabel.font = style.mainTextFont
        titleLabel.textColor = style.mainTextColor
        titleLabel.numberOfLines = 2
        topBackgroudView.addSubview(titleLabel)
        titleLabel.sizeToFit()
        
        subTitleLabel.text = style.subTitle
        subTitleLabel.textAlignment = .center
        subTitleLabel.font = style.subTextFont
        subTitleLabel.textColor = style.subTextColor
        topBackgroudView.addSubview(subTitleLabel)
        subTitleLabel.sizeToFit()
        
        leftBtn.setTitle(style.leftText, for: .normal)
        leftBtn.setTitleColor(style.leftTextColor, for: .normal)
        leftBtn.titleLabel?.font = style.leftTextFont
        leftBtn.backgroundColor = style.leftBackgroundColor
        leftBtn.addTarget(self, action: #selector(leftBtnClick(btn:)), for: .touchUpInside)
        addSubview(leftBtn)
        
        rightBtn.titleLabel?.font = style.rightTextFont
        rightBtn.setTitle(style.rightText, for: .normal)
        rightBtn.setTitleColor(style.rightTextColor, for: .normal)
        rightBtn.backgroundColor = style.rightBackgroundColor
        rightBtn.addTarget(self, action: #selector(rightBtnClick(btn:)), for: .touchUpInside)
        addSubview(rightBtn)
        
        horizontalLine.backgroundColor = style.horizontalLineColor
        addSubview(horizontalLine)
        
        verticalLine.backgroundColor = style.verticalLineColor
        addSubview(verticalLine)
    }
}

extension XJMaskAlertView: XJPopoverAnimatorable {
    @objc fileprivate func leftBtnClick(btn: UIButton) {
        if self.leftClickCallBack != nil {
            willCloseMask()
            self.leftClickCallBack!(btn)
        }
    }
    
    @objc fileprivate func rightBtnClick(btn: UIButton) {
        if self.rightClickCallBack != nil {
            willCloseMask()
            self.rightClickCallBack!(btn)
        }
    }
    
    func btnClick(leftClickCallBack: @escaping(_ leftBtn: UIButton) -> (), rightClickCallBack: @escaping(_ rightBtn: UIButton) -> ()) {
        self.leftClickCallBack = leftClickCallBack
        self.rightClickCallBack = rightClickCallBack
    }
}
