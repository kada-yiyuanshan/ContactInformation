//
//  PaiGoAppDelegate.h
//  PaiGo
//
//  Created by apple  on 12-10-11.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import <UIKit/UIKit.h>

@class PaiGoViewController;

@interface PaiGoAppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate,UIActionSheetDelegate>
{
    UITabBarController *tabbarController;
}
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabbarController;

@end
