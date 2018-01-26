//
//  XJMaskStyle.swift
//  蒙版层组件
//
//  Created by shanlin on 2017/10/20.
//  Copyright © 2017年 shanlin. All rights reserved.
//
/*
 """
 要删
 除"XJTabModule_Example"吗?
 """
 */

import UIKit
private let kNormalHeight: CGFloat = 150

public enum XJMaskStyleAnimType {
    /// 移动动画
    case moveAnim
    /// 专场动画
    case transitionAnim
}

public enum XJMaskAnimPresentDirection {
    /// 从上面出来
    case moveUp
    /// 从下面出来
    case moveDown
}

public enum XJMaskAnimDismissDirection {
    /// 从下面消失
    case moveDown
    /// 从上面消失
    case moveUp
}

public class XJMaskStyle {
    
    public init() {}
    
    /// 弹出来的内容视图尺寸
    public var presentedFrame: CGRect = CGRect(x: 40, y: (UIScreen.main.bounds.height - kNormalHeight) * 0.5, width: UIScreen.main.bounds.width - 80, height: kNormalHeight)
    /// 蒙层尺寸: 可以修改蒙版的上下位置 （y 和 h 值有效）
    public var presentedMaskFrame: CGRect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    /// 蒙层内容视图的圆角大小
    public var presentedCornerRadius: CGFloat = 10
    
    /// 弹出来的动画和消失动画时长
    public var presentDruration: TimeInterval = 0.45
    /// 弹出来的蒙层透明度
    public var presentAlpha: CGFloat = 0.25
    /// 弹出来的蒙层背景颜色
    public var presentBackgroundColor: UIColor = UIColor.black
    /// 蒙层是否隐藏
    public var isHiddenPresented: Bool = false
    /// 蒙版层是否可以点击关闭：默认可以点击关闭 
    public var isCanPresentClose: Bool = true
    
    /// 弹出视图的动画: 默认是移动动画 
    public var animType: XJMaskStyleAnimType = .moveAnim
    /// 移动弹出动画的方向: 默认从上面出来
    public var presentAnimDirection: XJMaskAnimPresentDirection = .moveUp
    /// 移动消失动画的方向: 默认从下面消失 
    public var dismissAnimDirection: XJMaskAnimDismissDirection = .moveDown
    /// 从里到外弹出动画的比值scale
    public var presentScale: CGAffineTransform = CGAffineTransform(scaleX: 0.2, y: 0.2)
    /// 从外到里消失动画的比值scale
    public var dismissScale: CGAffineTransform = CGAffineTransform(scaleX: 0.01, y: 0.01)
    /// 弹出动画的锚点
    public var anchorPoint: CGPoint = CGPoint(x: 0.5, y: 0.5)
    
    /// 弹出是否有弹簧效果: 默认具有
    public var isSpringEffect: Bool = true
    /// 弹出弹簧效果的阻力系数（0～1:由大到小震荡）
    public var DampingValue: CGFloat = 0.7
    /// 弹出弹簧的初始化速度大小
    public var initialSpringVelocity: CGFloat = 3.0
    
    
    
    // ======================== AlertViewController  ======================== //
    /// 底部两个按钮的高度: 默认为整个弹窗的1/3
    public var twoBtnHeight: CGFloat = kNormalHeight / 3
    /// 顶部背景色
    public var topBackgroundColor: UIColor = UIColor.white
    
    /// 主标题：mainTitle: 欢迎使用全新style
    public var mainTitle: String = "欢迎使用全新style"
    /// 主标题文字颜色
    public var mainTextColor: UIColor = UIColor.black
    /// 主标题文字字体大小
    public var mainTextFont: UIFont = UIFont.systemFont(ofSize: 18)
    /// 主标题距离左边和右边的边缘距离edge
    public var leftEdge: CGFloat = 15
    
    /// 副标题： SubTitle
    public var subTitle: String = ""
    /// 副标题文字颜色
    public var subTextColor: UIColor = UIColor.black
    /// 副标题文字字体大小
    public var subTextFont: UIFont = UIFont.systemFont(ofSize: 15)
    
    /// 主标题距离顶部的间距
    public var mainTitleTopMargin: CGFloat = 30
    /// 副标题距离主标题的间距
    public var subTitleToMainMargin: CGFloat = 10
    

    /// 左边文字
    public var leftText: String = "取消"
    /// 左边文字颜色
    public var leftTextColor: UIColor = UIColor.black
    /// 左边文字字体大小
    public var leftTextFont: UIFont = UIFont.systemFont(ofSize: 18)
    /// 左边区域背景色
    public var leftBackgroundColor: UIColor = UIColor.white
    
    /// 右边文字
    public var rightText: String = "确定"
    /// 右边文字颜色
    public var rightTextColor: UIColor = UIColor.orange
    /// 右边文字字体大小
    public var rightTextFont: UIFont = UIFont.systemFont(ofSize: 18)
    /// 右边区域背景色
    public var rightBackgroundColor: UIColor = UIColor.white
    
    /// 水平线条颜色
    public var horizontalLineColor: UIColor = UIColor.gray
    /// 垂直线条颜色
    public var verticalLineColor: UIColor = UIColor.gray

}
