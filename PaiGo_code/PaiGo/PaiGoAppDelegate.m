//
//  PaiGoAppDelegate.m
//  PaiGo
//
//  Created by apple  on 12-10-11.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import "PaiGoAppDelegate.h"

#import "PaiGoHomePageController.h"
#import "PaiGoNearController.h"
#import "PaiGoPaiMaController.h"
#import "PaiGoMoreController.h"


@implementation PaiGoAppDelegate
@synthesize tabbarController;
- (void)dealloc
{
    [_window release];
    [tabbarController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];

    PaiGoHomePageController *Homepage = [[[PaiGoHomePageController alloc] initWithNibName:@"PaiGoHomePageController" bundle:nil] autorelease];
    Homepage.login_status=YES;

    UINavigationController *HomepageNavigation=[[[UINavigationController alloc] initWithRootViewController:Homepage] autorelease];
    
    PaiGoNearController *Nearpage=[[[PaiGoNearController alloc] initWithNibName:@"PaiGoNearController" bundle:Nil] autorelease];
    UINavigationController *NearpageNavigation=[[[UINavigationController alloc]initWithRootViewController:Nearpage] autorelease];
    
    PaiGoPaiMaController *PaiMaPage=[[[PaiGoPaiMaController alloc] initWithNibName:@"PaiGoPaiMaController" bundle:Nil] autorelease];
    UINavigationController *PaiMaPageNavigation=[[[UINavigationController alloc]initWithRootViewController:PaiMaPage] autorelease];
    
    PaiGoMoreController *MorePage=[[[PaiGoMoreController alloc] initWithNibName:@"PaiGoMoreController" bundle:Nil] autorelease];
    UINavigationController *MorePageNavigation=[[[UINavigationController alloc]initWithRootViewController:MorePage] autorelease];
    
    self.tabbarController=[[UITabBarController alloc] init];
    
   [[self.tabbarController tabBar]setBackgroundImage:[[UIImage imageNamed:@"TabBarbackground.png"] stretchableImageWithLeftCapWidth:14 topCapHeight:0]];
    self.tabbarController.viewControllers=@[HomepageNavigation,NearpageNavigation,PaiMaPageNavigation,MorePageNavigation];
    [(UITabBarItem *)[self.tabbarController.tabBar.items objectAtIndex:0] setImage:[UIImage imageNamed:@"shouye.png"]];
    [(UITabBarItem *)[self.tabbarController.tabBar.items objectAtIndex:1] setImage:[UIImage imageNamed:@"arrow_detail.png"]];
    [(UITabBarItem *)[self.tabbarController.tabBar.items objectAtIndex:2] setImage:[UIImage imageNamed:@"arrow_detail.png"]];
    [(UITabBarItem *)[self.tabbarController.tabBar.items objectAtIndex:3] setImage:[UIImage imageNamed:@"arrow_detail.png"]];
    self.window.rootViewController = self.tabbarController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
