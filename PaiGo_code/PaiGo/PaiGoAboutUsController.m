//
//  PaiGoAboutUsController.m
//  PaiGo
//
//  Created by apple  on 12-10-15.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import "PaiGoAboutUsController.h"
#import "PaiGoWebViewController.h"

@interface PaiGoAboutUsController ()

@end

@implementation PaiGoAboutUsController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"关于我们";
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
-(IBAction)webButtonclick:(id)sender
{
        PaiGoWebViewController *WebViewController = [[PaiGoWebViewController alloc] initWithNibName:@"PaiGoWebViewController" bundle:nil];
        [self.navigationController pushViewController:WebViewController animated:YES];
        [WebViewController release];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
