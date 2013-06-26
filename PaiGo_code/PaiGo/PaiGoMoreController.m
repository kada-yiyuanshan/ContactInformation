//
//  PaiGoMoreController.m
//  PaiGo
//
//  Created by apple  on 12-10-11.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import "PaiGoMoreController.h"
#import "PaiGoLoginController.h"
#import "PaiGoAboutUsController.h"
#import "PaiGoMoreYouHuiController.h"
@interface PaiGoMoreController ()

@end

@implementation PaiGoMoreController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"更多";
    }
    return self;
}

- (void)viewDidLoad
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavigationBarbackground.png"] forBarMetrics:UIBarMetricsDefault];
    [super viewDidLoad];

}

- (void)viewDidUnload
{
    
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(IBAction)UserCenterBtnClick:(id)sender
{
    PaiGoLoginController *LoginController = [[PaiGoLoginController alloc] initWithNibName:@"PaiGoLoginController" bundle:nil];
    [self.navigationController pushViewController:LoginController animated:YES];
    
    [LoginController release];
}
-(IBAction)AboutUsBtnClick:(id)sender
{
    PaiGoAboutUsController *AboutUsController = [[PaiGoAboutUsController alloc] initWithNibName:@"PaiGoAboutUsController" bundle:nil];
    [self.navigationController pushViewController:AboutUsController animated:YES];
    
    [AboutUsController release];

}
-(IBAction)youhuiclick:(id)sender
{
    PaiGoMoreYouHuiController *youhuiController = [[PaiGoMoreYouHuiController alloc] initWithNibName:@"PaiGoMoreYouHuiController" bundle:nil];
    [self.navigationController pushViewController:youhuiController animated:YES];
    [youhuiController release];
}

@end
