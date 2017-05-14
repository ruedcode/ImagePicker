//
//  ImagePickerControllerAnimation.swift
//  Pods
//
//  Created by Evgeniy Kalyada on 14/05/2017.
//
//

import UIKit

class ImagePickerControllerAnimationLibrary: NSObject, UIViewControllerAnimatedTransitioning {
    
    var originFrame: CGRect
    var offsetFrame: CGRect
    
    init(originFrame: CGRect, fromFrame: CGRect) {
        self.originFrame = originFrame
        self.offsetFrame = fromFrame
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
//        let fromView = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!.view
        if let toView = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)?.view {
            var frame = offsetFrame
            frame.size.height = 0
            toView.frame = frame
            print("frame \(frame) \(self.offsetFrame.height)")
            containerView.addSubview(toView)
            
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                toView.frame = CGRect(x:0, y: -(self.originFrame.height - frame.origin.y), width:self.originFrame.width, height:self.originFrame.height)
                        }, completion: { (completed: Bool) -> Void in
                            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                                toView.frame.origin.y = 0
                            }, completion: {  (completed: Bool) -> Void in
                                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                            })
                            
                        })
        }
        else {
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
        
//        let detailView = self.isPresenting ? toView : fromView
//        
//        if self.isPresenting {
//            
//
//        } else {
//            containerView.insertSubview(toView!, belowSubview: fromView!)
//        }
//        
//        detailView?.frame.origin = self.isPresenting ? self.originFrame.origin : CGPoint(x: 0, y: 0)
//        detailView?.frame.size.width = self.isPresenting ? self.originFrame.size.width : containerView.bounds.width
//        detailView?.layoutIfNeeded()
//        
//        for view in (detailView?.subviews)! {
//            if !(view is UIImageView) {
//                view.alpha = isPresenting ? 0.0 : 1.0
//            }
//        }
//        
//        UIView.animate(withDuration: self.duration, animations: { () -> Void in
//            detailView?.frame = self.isPresenting ? containerView.bounds : self.originFrame
//            detailView?.layoutIfNeeded()
//            
//            for view in (detailView?.subviews)! {
//                if !(view is UIImageView) {
//                    view.alpha = self.isPresenting ? 1.0 : 0.0
//                }
//            }
//        }, completion: { (completed: Bool) -> Void in
//            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
//        })
        
    }
    
}

