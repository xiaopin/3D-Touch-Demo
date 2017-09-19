//
//  XPPresentViewController.m
//  3D-Touch
//
//  Created by nhope on 2017/9/19.
//  Copyright © 2017年 nhope. All rights reserved.
//

#import "XPPresentViewController.h"

@interface XPPresentViewController ()

@end

@implementation XPPresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissButtonAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
