//
//  PaiGoHomeTableViewItemController.m
//  PaiGo
//
//  Created by apple  on 12-10-17.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import "PaiGoHomeTableViewItemController.h"

@interface PaiGoHomeTableViewItemController ()

@end

@implementation PaiGoHomeTableViewItemController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
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
