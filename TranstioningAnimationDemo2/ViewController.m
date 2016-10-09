//
//  ViewController.m
//  TranstioningAnimationDemo2
//
//  Created by JiongXing on 2016/10/8.
//  Copyright © 2016年 JiongXing. All rights reserved.
//

#import "ViewController.h"
#import "RWLogoLayer.h"
#import "RevealAnimator.h"
#import "DetailViewController.h"

@interface ViewController () <UINavigationControllerDelegate>

@property (nonatomic, strong) RevealAnimator *transition;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.logo = [RWLogoLayer logoLayer];
    self.transition = [[RevealAnimator alloc] init];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.navigationItem.title = @"START";
    self.navigationController.delegate = self;
    
    UILabel *promptLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.text = @"滑 动 解 锁";
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:20];
        label;
    });
    [promptLabel sizeToFit];
    promptLabel.center = CGPointMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height - 80);
    [self.view addSubview:promptLabel];
    
    self.view.userInteractionEnabled = YES;
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap)];
//    [self.view addGestureRecognizer:tap];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)];
    [self.view addGestureRecognizer:pan];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.logo.position = CGPointMake(self.view.layer.bounds.size.width / 2.0, self.view.layer.bounds.size.height / 2.0 + 30);
    self.logo.fillColor = [UIColor whiteColor].CGColor;
    [self.view.layer addSublayer:self.logo];
}

//- (void)didTap {
//    DetailViewController *vc = [[DetailViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
//}

- (void)didPan:(UIPanGestureRecognizer *)pan {
    switch (pan.state) {
        case UIGestureRecognizerStateBegan: {
            self.transition.interactive = YES;
            DetailViewController *vc = [[DetailViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            [self.transition handlePan:pan];
            break;
    }
}

// 返回一个不可交互的转场动画
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    self.transition.operation = operation;
    return self.transition;
}

// 返回一个可以交互的转场动画
- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    if (!self.transition.interactive) {
        return nil;
    }
    return self.transition;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
