//
//  AppDelegate.m
//  3D-Touch
//
//  Created by nhope on 2017/9/19.
//  Copyright © 2017年 nhope. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (nonatomic, strong) UIApplicationShortcutItem *launchedShortcutItem;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    BOOL shouldPerformAdditionalDelegateHandling = YES;
    UIApplicationShortcutItem *shortcutItem = [launchOptions valueForKey:UIApplicationLaunchOptionsShortcutItemKey];
    if (shortcutItem) {
        _launchedShortcutItem = shortcutItem;
        shouldPerformAdditionalDelegateHandling = NO;
    }
    // 动态增加ShortcurItem
    UIApplicationShortcutItem *dynamicShortcutItem = [[UIApplicationShortcutItem alloc] initWithType:@"com.0daybug.dynamic" localizedTitle:@"动态添加" localizedSubtitle:nil icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeCompose] userInfo:nil];
    NSMutableArray *shortcutItems = [NSMutableArray array];
    [shortcutItems addObjectsFromArray:[UIApplication sharedApplication].shortcutItems];
    [shortcutItems addObject:dynamicShortcutItem];
    [UIApplication sharedApplication].shortcutItems = shortcutItems;
    
    return shouldPerformAdditionalDelegateHandling;
}


- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    [self handleShortcutItem:shortcutItem];
    if (completionHandler) {
        completionHandler(YES);
    }
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    if (_launchedShortcutItem) {
        [self handleShortcutItem:_launchedShortcutItem];
        _launchedShortcutItem = nil;
    }
}

#pragma mark - Private

/// 处理3D Touch事件
- (void)handleShortcutItem:(UIApplicationShortcutItem *)shortcutItem {
    if (!shortcutItem) {
        return;
    }
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    UINavigationController *navController = (UINavigationController *)tabBarController.selectedViewController;
    
    // 递归地关闭present的控制器
    if (navController.presentedViewController) {
        static void(^dismissPresentedViewControllerForViewController)(UIViewController *) = ^(UIViewController *vc) {
            if (vc.presentedViewController) {
                dismissPresentedViewControllerForViewController(vc.presentedViewController);
            }
            [vc dismissViewControllerAnimated:NO completion:nil];
        };
        dismissPresentedViewControllerForViewController(navController.presentedViewController);
    }
    
    // 处理页面跳转
    if ([shortcutItem.type isEqualToString:@"com.0daybug.dynamic"]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"点击了动态添加的ShortcutItem" message:shortcutItem.type delegate:nil cancelButtonTitle:@"Done" otherButtonTitles:nil, nil];
            [alertView show];
        });
    }
    else if ([shortcutItem.type isEqualToString:@"com.0daybug.receive"]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"待收货" message:shortcutItem.type delegate:nil cancelButtonTitle:@"Done" otherButtonTitles:nil, nil];
            [alertView show];
        });
    }
    else if ([shortcutItem.type isEqualToString:@"com.0daybug.shoppingcart"]) {
        if (tabBarController.selectedIndex == 1) {
            [navController popToRootViewControllerAnimated:NO];
        } else {
            tabBarController.selectedIndex = 1;
        }
    }
    else if ([shortcutItem.type isEqualToString:@"com.0daybug.search"]) {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *searchViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"SearchViewController"];
        [navController pushViewController:searchViewController animated:YES];
    }
}


@end
