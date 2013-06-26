//
//  ContactInformationAppDelegate.h
//  ContactInformation
//
//  Created by apple  on 12-10-30.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import <UIKit/UIKit.h>

@class ContactInformationViewController;

@interface ContactInformationAppDelegate : UIResponder <UIApplicationDelegate,UINavigationControllerDelegate,UINavigationBarDelegate>
{
    
UINavigationController *navigationcontroller;

}
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController *navigationcontroller;

@end
