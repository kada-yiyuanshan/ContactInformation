//
//  PaiGoWebViewController.m
//  PaiGo
//
//  Created by apple  on 12-10-29.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import "PaiGoWebViewController.h"

@interface PaiGoWebViewController ()

@end

@implementation PaiGoWebViewController

@synthesize WebView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
-(void)dealloc
{
    [WebView release];
    [super dealloc];
}
- (void)viewDidLoad
{
    self.WebView.scalesPageToFit = YES;
    self.WebView.delegate = self;
    
    [self.WebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com/"]]];
    //www.aokj.com.cn
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    self.WebView = nil;
    [super viewDidUnload];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark -
#pragma mark UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{

	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{

	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	NSString* errorString = [NSString stringWithFormat:
							 @"<html><center><font size=+5 color='red'>An error occurred:<br>%@</font></center></html>",
							 error.localizedDescription];
	[self.WebView loadHTMLString:errorString baseURL:nil];
}

@end
