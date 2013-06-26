//
//  AddViewController.h
//  ContactInformation
//
//  Created by apple  on 12-10-31.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface AddViewController : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,MFMailComposeViewControllerDelegate,UIAlertViewDelegate>
{
    
    UITextField *firstname;
    UITextField *lastname;
    UITextField *phone;
    UITextField *email;
    UITextField *address;
    BOOL b_Edit;
    UISegmentedControl *gendersegment;
    NSInteger segmentindex;
    int keyBoardMargin_;
    UILabel *firstlable;
    UILabel *lastlable;
    UILabel *genderlable;
    UILabel *phonelable;
    UILabel *emaillable;
    UILabel *addresslable;
    UIButton *sendemail;
    UIButton *mapview;

    
}

@property(retain,nonatomic) UIButton *mapview;
@property(retain,nonatomic) UIButton *sendemail;
@property(retain,nonatomic) UILabel *firstlable;
@property(retain,nonatomic) UILabel *lastlable;
@property(retain,nonatomic) UILabel *genderlable;
@property(retain,nonatomic) UILabel *phonelable;
@property(retain,nonatomic) UILabel *emaillable;
@property(retain,nonatomic) UILabel *addresslable;
@property(assign,nonatomic) int keyBoardMargin_;
@property(assign,nonatomic) NSInteger segmentindex;
@property(retain,nonatomic) UISegmentedControl *gendersegment;
@property(assign,nonatomic) BOOL b_Edit;
@property(strong, nonatomic) id detailItem;
@property(retain,nonatomic) UITextField *firstname;
@property(retain,nonatomic) UITextField *lastname;
@property(retain,nonatomic) UITextField *phone;
@property(retain,nonatomic) UITextField *email;
@property(retain,nonatomic) UITextField *address;

-(IBAction)backgroundclick:(id)sender;
-(IBAction)saveclick:(id)sender;
-(IBAction)updataclick:(id)sender;
-(IBAction)mapviewclick:(id)sender;

-(void)moveView:(UITextField *)textField leaveView:(BOOL)leave;
-(void)messagtitle:(NSString *)title message:(NSString *)messages;

@end
