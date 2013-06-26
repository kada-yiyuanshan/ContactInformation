//
//  PaiGoWebViewController.h
//  PaiGo
//
//  Created by apple  on 12-10-29.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaiGoWebViewController : UIViewController<UIWebViewDelegate>
{
    UIWebView	*myWebView;
}
@property (nonatomic, retain) IBOutlet  UIWebView	*WebView;

@end
