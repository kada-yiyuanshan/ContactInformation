//
//  PaiGoPaiMaController.m
//  PaiGo
//
//  Created by apple  on 12-10-11.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import "PaiGoPaiMaController.h"

@interface PaiGoPaiMaController ()

@end

@implementation PaiGoPaiMaController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"拍码";
    }
    return self;
}

- (void)viewDidLoad
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavigationBarbackground.png"] forBarMetrics:UIBarMetricsDefault];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
