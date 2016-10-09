//
//  RevealAnimator.m
//  TranstioningAnimationDemo2
//
//  Created by JiongXing on 2016/10/9.
//  Copyright © 2016年 JiongXing. All rights reserved.
//

#import "RevealAnimator.h"

@implementation RevealAnimator {
    CGFloat animationDuration;
    id<UIViewControllerContextTransitioning> storedContext;
}

- (instancetype)init {
    if (self = [super init]) {
        animationDuration = 1.0;
        self.operation = UINavigationControllerOperationPush;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return animationDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    storedContext = transitionContext;
    if (self.operation == UINavigationControllerOperationPush) {
        ViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        DetailViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        [[transitionContext containerView] addSubview:toVC.view];
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
        animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        
        // 添加阴影效果
        animation.toValue = [NSValue valueWithCATransform3D:CATransform3DConcat(CATransform3DMakeTranslation(0.0, -10.0, 0.0), CATransform3DMakeScale(150.0, 150.0, 1.0))];
        
        animation.duration = animationDuration;
        animation.delegate = self;
        animation.fillMode = kCAFillModeForwards;
        animation.removedOnCompletion = false;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        
        // 同时添加到两个控制器上
        [toVC.maskLayer addAnimation:animation forKey:nil];
        [fromVC.logo addAnimation:animation forKey:nil];
        
        // 给目的控制器设置一个渐变效果
        CABasicAnimation *fadeIn = [CABasicAnimation animationWithKeyPath:@"opacity"];
        fadeIn.fromValue = @0;
        fadeIn.toValue = @1;
        fadeIn.duration = animationDuration;
        [toVC.view.layer addAnimation:fadeIn forKey:nil];
    }
    else {
        UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        
        [[transitionContext containerView] insertSubview:toView belowSubview:fromView];
        
        [UIView animateWithDuration:animationDuration animations:^{
            fromView.transform = CGAffineTransformMakeScale(0.001, 0.001);
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
}

// CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (storedContext) {
        [storedContext completeTransition:![storedContext transitionWasCancelled]];
        ViewController *fromVC = [storedContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        [fromVC.logo removeAllAnimations];
    }
    storedContext = nil;
}

- (void)handlePan:(UIPanGestureRecognizer *)pan {
    CGPoint translation = [pan translationInView:pan.view.superview];
    CGFloat progress = ABS(translation.x / 200.0);
    progress = MIN(MAX(progress, 0.01), 0.99);
    
    switch (pan.state) {
        case UIGestureRecognizerStateChanged:
            [self updateInteractiveTransition:progress];
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded: {
            if (self.operation == UINavigationControllerOperationPush) { // push
                CALayer *transitionLayer = [storedContext containerView].layer;
                transitionLayer.beginTime = CACurrentMediaTime();
                if (progress < 0.5) {
                    self.completionSpeed = -1.0;
                    [self cancelInteractiveTransition];
                }
                else {
                    self.completionSpeed = 1.0;
                    [self finishInteractiveTransition];
                }
            }
            else { // pop
                if (progress < 0.5) {
                    [self cancelInteractiveTransition];
                }
                else {
                    [self finishInteractiveTransition];
                }
            }
            // 重置动画
            self.interactive = NO;
        }
            break;
        default:
            break;
    }
}

@end
