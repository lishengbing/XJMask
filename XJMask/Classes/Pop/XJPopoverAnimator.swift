//
//  XJPopoverAnimator.swift
//  蒙版层组件
//
//  Created by shanlin on 2017/10/20.
//  Copyright © 2017年 shanlin. All rights reserved.
//

import UIKit

 public class XJPopoverAnimator: NSObject {

    // MARK: - 对外属性
    var style: XJMaskStyle!
    
    // MARK: - 对内属性 
    fileprivate var callBack : ((_ isPresented : Bool) -> ())? = nil
    fileprivate var isPresented: Bool = false
    
    init(_ callBack: @escaping(_ isPresented : Bool) -> ()) {
        super.init()
        self.callBack = callBack
    }
}

// MARK: - 自定义专场代理的方法
extension XJPopoverAnimator : UIViewControllerTransitioningDelegate {
    
    // 目的:改变弹出view的尺寸
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        let presentedView = XJPresentParentVC(presentedViewController: presented, presenting: presenting)
        presentedView.style = style
        return presentedView
    }
    
    // 目的:自定义专场的弹出动画
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = true
        callBack!(isPresented)
        return self
    }
    
    // 目的:自定义专场的消失动画
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = false
        callBack!(isPresented)
        return self
    }
}

// MARK: - 实现弹出和消失动画的代理方法
extension XJPopoverAnimator : UIViewControllerAnimatedTransitioning {
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return style.presentDruration
    }
    
    // 获取专场的上下文"transitionContext"，通过转场上下文获取弹出的veiw和消失的view
    // UITransitionContextToViewKey   : 获取弹出的veiw
    // UITransitionContextFromViewKey    : 获取消失的view
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        isPresented ? xj_animationForPresented(transitionContext: transitionContext) : xj_animationForDismissed(transitionContext: transitionContext)
    }
    
    // 自定义弹出的动画设置
    func xj_animationForPresented(transitionContext: UIViewControllerContextTransitioning) {
        // 1.获取弹出的veiw
        let presentedVeiw = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        
        // 2.自定义动画就需要手动将弹出的veiw加到containerView上去
        transitionContext.containerView.addSubview(presentedVeiw)
        
        // 3.设置动画
        if style.animType == .transitionAnim {
            presentedVeiw.transform = style.presentScale
            presentedVeiw.layer.anchorPoint = style.anchorPoint
            let damping = style.isSpringEffect ? style.DampingValue : 1.0
            UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: damping, initialSpringVelocity: style.initialSpringVelocity, options: [], animations: {
                presentedVeiw.transform = CGAffineTransformFromString("CGAffineTransformIdentity")
            }) { (_) in
                transitionContext.completeTransition(true)
            }
        }else if style.animType == .moveAnim {
            // 执行动画
            // Damping:阻力系数，阻力系数越大，弹簧的效果越不明显 0～1
            // initialSpringVelocity 初始化速度
            // options ,传枚举值，如果不想传，就只要传一个空的数组
            let damping = style.isSpringEffect ? style.DampingValue : 1.0
            UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: damping, initialSpringVelocity: style.initialSpringVelocity, options: [], animations: {
                if self.style.presentAnimDirection == .moveUp {
                    presentedVeiw.frame.origin.y = self.style.presentedFrame.origin.y
                }else if self.style.presentAnimDirection == .moveDown {
                    presentedVeiw.frame.origin.y = -self.style.presentedFrame.origin.y
                }
            }) { (_) in
                transitionContext.completeTransition(true)
            }
        }
    }
    
    // 自定义消失的动画设置
    func xj_animationForDismissed(transitionContext: UIViewControllerContextTransitioning){
        // 获取消失的view
        let dismissedView = transitionContext.view(forKey: UITransitionContextViewKey.from)!

        // 设置消失动画
        if style.animType == .transitionAnim {
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                dismissedView.transform = self.style.dismissScale
            }) { (_) in
                dismissedView.removeFromSuperview()
                transitionContext.completeTransition(true)
            }
        }else if style.animType == .moveAnim {
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                var y: CGFloat = 0
                if self.style.dismissAnimDirection == .moveDown {
                    y = self.style.isHiddenPresented ? (UIScreen.main.bounds.height - self.style.presentedFrame.origin.y) : (dismissedView.superview?.bounds.height)!
                }else if self.style.dismissAnimDirection == .moveUp {
                    y = self.style.isHiddenPresented ? -(self.style.presentedFrame.height + self.style.presentedFrame.origin.y) : -self.style.presentedFrame.height
                }
                dismissedView.frame.origin.y = y
            }) { (_) in
                dismissedView.removeFromSuperview()
                transitionContext.completeTransition(true)
            }
        }
    }
}

