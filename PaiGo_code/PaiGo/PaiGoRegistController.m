//
//  PaiGoRegistController.m
//  PaiGo
//
//  Created by apple  on 12-10-15.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import "PaiGoRegistController.h"

@interface PaiGoRegistController ()

@end

@implementation PaiGoRegistController
@synthesize EmailText,PhoneNumberText,PassWordText,ConfirmationPassWordText;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"注册帐号";
    }
    return self;
}

- (void)viewDidLoad
{
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
-(IBAction)RegistViewclick:(id)sender
{
    [self.EmailText  resignFirstResponder];
    [self.PassWordText resignFirstResponder];
    [self.PhoneNumberText resignFirstResponder];
    [self.ConfirmationPassWordText resignFirstResponder];
 }
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    if (0 == [indexPath section]) {
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        if (0 == indexPath.row) {
            cell.textLabel.text = @"邮箱:";
            cell.textLabel.textColor=[UIColor lightGrayColor];
            EmailText = [[UITextField alloc] initWithFrame:CGRectMake(92, 12, 200, 24)];
            EmailText.delegate=self;
            EmailText.placeholder = @"输入邮箱地址";
            [cell addSubview:EmailText];
        }
        if (1 == indexPath.row) {
            cell.textLabel.text = @"电话号码:";
            cell.textLabel.textColor=[UIColor lightGrayColor];
            PhoneNumberText = [[UITextField alloc] initWithFrame:CGRectMake(92, 12, 200, 24)];
            PhoneNumberText.delegate=self;
            PhoneNumberText.placeholder = @"输入电话号码";
            [cell addSubview:PhoneNumberText];
        }
        if (2 == indexPath.row) {
            cell.textLabel.text = @"密码:";
            cell.textLabel.textColor=[UIColor lightGrayColor];
            PassWordText = [[UITextField alloc] initWithFrame:CGRectMake(92, 12, 200, 24)];
            PassWordText.delegate=self;
            PassWordText.placeholder = @"请输入密码";
            [cell addSubview:PassWordText];
        }
        if (3 == indexPath.row) {
            cell.textLabel.text = @"确认密码:";
            cell.textLabel.textColor=[UIColor lightGrayColor];
            ConfirmationPassWordText = [[UITextField alloc] initWithFrame:CGRectMake(92, 12, 200, 24)];
            ConfirmationPassWordText.delegate=self;
            ConfirmationPassWordText.placeholder = @"请重新输入密码";
            [cell addSubview:ConfirmationPassWordText];
        }

    }
    
    return cell;
}


#pragma make - TextField
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{   
    [textField resignFirstResponder];
    return YES;
}
-(void)dealloc
{
    [EmailText release];
    [PassWordText release];
    [PhoneNumberText release];
    [ConfirmationPassWordText release];
    [super dealloc];
}
@end
