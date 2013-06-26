//
//  PaiGoLoginController.h
//  PaiGo
//
//  Created by apple  on 12-10-15.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaiGoLoginController : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UITextField *EmailText;
    UITextField *userpasswordText;
    NSURLConnection *login_url;
    NSMutableData *login_data;
    NSMutableArray *login_userdata;
}

@property (retain,nonatomic) UITextField *EmailText;
@property (retain,nonatomic) UITextField *userpasswordText;
@property (retain,nonatomic) NSMutableArray *login_userdata;

-(IBAction)GoRegistBtnClick:(id)sender;
-(IBAction)LoginViewClick:(id)sender;
-(IBAction)LoginClick:(id)sender;

@end
