//
//  BubbleTransition.swift
//  BubbleTransition-swift
//
//  Created by weixiaoyun on 15/7/13.
//  Copyright (c) 2015年 weixiaoyun. All rights reserved.
//

import UIKit

class LayerAnimator : NSObject {
    
    var complitionBlock: (()->Void)?
    var animLayer: CALayer?
    var caAnimation: CAAnimation?
    
    init(layer: CALayer, animation: CAAnimation) {
        
        self.caAnimation = animation;
        self.animLayer = layer;
    }
    
    func startAnimationWithBlock(block:(()->Void)) {
        self.caAnimation?.delegate = self
        self.complitionBlock = block;
        
        self.animLayer?.addAnimation(self.caAnimation!, forKey: "anim")
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        self.caAnimation?.delegate = nil
        self.complitionBlock?()
    }
}

public class BubbleTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    public var startRect = CGRectZero
   
    public var duration = 0.5
    
    public var transitionMode: BubbleTransitionMode = .Present
    
    public var bubbleColor: UIColor = .whiteColor()
    
    private var maskLayer: CAShapeLayer! = CAShapeLayer()
    
    // UIViewControllerAnimatedTransitioning
    public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration
    }
    
    public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView()
        
        if transitionMode == .Present {
            let presentedController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
            presentedController.view.backgroundColor = bubbleColor;
            
            let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
            containerView!.insertSubview(presentedController.view, aboveSubview: fromViewController.view)
            
            self.bubblePresentView(presentedController.view, fromRect: self.startRect, completeBlock: { () -> Void in
                transitionContext.completeTransition(true)
            })
            
        } else if transitionMode == .Dismiss {
            let returningController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
            self.bubbleDismissView(returningController.view, toRect: self.startRect, completeBlock: { () -> Void in
                returningController.view.removeFromSuperview()
                transitionContext.completeTransition(true)
            })
        } else {
            
        }
    }

    // BubbleAnimation
    
    func bubblePresentView(view: UIView, fromRect:CGRect, completeBlock:()->Void) {
        let fromPath = CGPathCreateWithEllipseInRect(fromRect, nil);
        self.maskLayer.path = fromPath;
        view.layer.mask = self.maskLayer;
        
        let d = sqrt(pow(view.frame.size.width, 2) + pow(view.frame.size.height, 2))*2;
        
        let toRect =  CGRectMake(view.frame.size.width/2-d/2 ,fromRect.origin.y-d/2, d, d);
        let toPath = CGPathCreateWithEllipseInRect(toRect, nil);
        self.bubbleAnimationFromValue(fromPath, toValue: toPath, completeBlock: completeBlock)
    }
    
    func bubbleDismissView(view: UIView, toRect:CGRect, completeBlock:()->Void) {
        let d = sqrt(pow(view.frame.size.width, 2) + pow(view.frame.size.height, 2))*2;
        
        let fromRect = CGRectMake(view.frame.size.width/2-d/2 ,toRect.origin.y-d/2, d, d);
        let fromPath = CGPathCreateWithEllipseInRect(fromRect, nil);
        self.maskLayer.path = fromPath;
        view.layer.mask = self.maskLayer;
        
        let toPath = CGPathCreateWithEllipseInRect(toRect, nil);
        
        self.bubbleAnimationFromValue(fromPath, toValue: toPath, completeBlock: completeBlock)
    }

    func bubbleAnimationFromValue(fromValue:CGPathRef, toValue:CGPathRef, completeBlock: ()->Void) {
        let bubbleAnimation = CABasicAnimation(keyPath: "path")
        bubbleAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        bubbleAnimation.fromValue = fromValue
        bubbleAnimation.toValue = toValue
        
        bubbleAnimation.duration = self.duration
        
        
        maskLayer.path=toValue
        
        let animator:LayerAnimator = LayerAnimator(layer: maskLayer, animation: bubbleAnimation)
        
        animator.startAnimationWithBlock { () -> Void in
            completeBlock()
        }
    }
   
    @objc public enum BubbleTransitionMode: Int {
        case Present, Dismiss
    }
}
