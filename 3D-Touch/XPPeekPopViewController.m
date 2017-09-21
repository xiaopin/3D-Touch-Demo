//
//  XPPeekPopViewController.m
//  3D-Touch
//
//  Created by nhope on 2017/9/19.
//  Copyright © 2017年 nhope. All rights reserved.
//

#import "XPPeekPopViewController.h"
#import "XPImageViewController.h"

@interface XPPeekPopViewController ()<UIViewControllerPreviewingDelegate>

@property (weak, nonatomic) IBOutlet UIButton *peekPopButton;

@end

@implementation XPPeekPopViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // 判断是否支持3D Touch
    if ([self respondsToSelector:@selector(traitCollection)]) {
        if ([self.traitCollection respondsToSelector:@selector(forceTouchCapability)]) {
            if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
                // 注册3D Touch事件
                [self registerForPreviewingWithDelegate:self sourceView:self.peekPopButton];
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 根据屏幕的按压力度来改变背景色
    // `touch.force`为用户当前按压屏幕的力度值
    UITouch *touch = [touches anyObject];
    CGFloat red = (touch.maximumPossibleForce - touch.force) / touch.maximumPossibleForce;
    UIColor *color = [UIColor colorWithRed:red green:1.0 blue:1.0 alpha:1.0];
    self.view.backgroundColor = color;
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.view.backgroundColor = [UIColor whiteColor];
}


#pragma mark - <UIViewControllerPreviewingDelegate>

- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
//    [self showDetailViewController:viewControllerToCommit sender:nil];
    [self.navigationController pushViewController:viewControllerToCommit animated:YES];
}


- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    // 创建需要显示的视图
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    XPImageViewController *imageViewController = (XPImageViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"XPImageViewController"];
    
    // 设置预览区域(可选)
//    previewingContext.sourceRect = CGRectMake(0, 0, 300.0, 400.0);
    
    // 返回需要预览的视图控制器
    return imageViewController;
}


@end
