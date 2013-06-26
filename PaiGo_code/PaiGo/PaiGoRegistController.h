//
//  PaiGoRegistController.h
//  PaiGo
//
//  Created by apple  on 12-10-15.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaiGoRegistController : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
 UITextField *EmailText,*PhoneNumberText,*PassWordText,*ConfirmationPassWordText;
}
@property (retain,nonatomic) UITextField *EmailText,*PhoneNumberText,*PassWordText,*ConfirmationPassWordText;

-(IBAction)RegistViewclick:(id)sender;
@end
