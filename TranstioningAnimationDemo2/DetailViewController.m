//
//  DetailViewController.m
//  TranstioningAnimationDemo2
//
//  Created by JiongXing on 2016/10/9.
//  Copyright © 2016年 JiongXing. All rights reserved.
//

#import "DetailViewController.h"
#import "RWLogoLayer.h"

@interface DetailViewController ()

@end

@implementation DetailViewController {
    UIImageView *bgImage;
    UILabel *descLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"DETAILVC";
    self.view.backgroundColor = [UIColor whiteColor];
    
    bgImage = ({
        UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"anise"]];
        bg.frame = self.view.bounds;
        bg;
    });
    [self.view addSubview:bgImage];
    
    descLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.text = @"DetailViewController";
        label.textColor = [UIColor cyanColor];
        label.font = [UIFont systemFontOfSize:30];
        label;
    });
    [self.view addSubview:descLabel];
    
    self.maskLayer = [RWLogoLayer logoLayer];
    self.maskLayer.position = CGPointMake(self.view.layer.bounds.size.width / 2.0, self.view.layer.bounds.size.height/2);
    self.view.layer.mask = self.maskLayer;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.view.layer.mask = nil;
}

@end
