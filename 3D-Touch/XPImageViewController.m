//
//  XPImageViewController.m
//  3D-Touch
//
//  Created by nhope on 2017/9/19.
//  Copyright © 2017年 nhope. All rights reserved.
//

#import "XPImageViewController.h"

@interface XPImageViewController ()

@end

@implementation XPImageViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 实现该方法即后，即可在预览`XPImageViewController`时，向上拖拽显示一个快捷功能菜单
 
 @return 菜单列表
 */
- (NSArray<id<UIPreviewActionItem>> *)previewActionItems {
    UIPreviewAction *action1 = [UIPreviewAction actionWithTitle:@"操作1" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"操作1");
    }];
    
    UIPreviewAction *action2 = [UIPreviewAction actionWithTitle:@"操作2" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"操作2");
    }];
    
    UIPreviewAction *cancelAction = [UIPreviewAction actionWithTitle:@"取消" style:UIPreviewActionStyleDestructive handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        // cancel.
    }];
    
    return @[action1, action2, cancelAction];
}


@end
