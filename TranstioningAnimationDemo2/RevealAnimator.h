//
//  RevealAnimator.h
//  TranstioningAnimationDemo2
//
//  Created by JiongXing on 2016/10/9.
//  Copyright © 2016年 JiongXing. All rights reserved.
//

@import UIKit;

@interface RevealAnimator : UIPercentDrivenInteractiveTransition <UIViewControllerAnimatedTransitioning, UIViewControllerInteractiveTransitioning>

@property (nonatomic, assign) UINavigationControllerOperation operation;
@property (nonatomic, assign) BOOL interactive;

- (void)handlePan:(UIPanGestureRecognizer *)pan;

@end

#import "RevealAnimator.h"
#import "ViewController.h"
#import "DetailViewController.h"

@interface RevealAnimator () <CAAnimationDelegate>

@end
