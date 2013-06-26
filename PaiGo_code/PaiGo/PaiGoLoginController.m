//
//  PaiGoLoginController.m
//  PaiGo
//
//  Created by apple  on 12-10-15.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import "PaiGoLoginController.h"
#import "PaiGoRegistController.h"
#import "ErrorBean.h"
#import "asyncimageview.h"
#import "LoginPeopleBean.h"
#import "LoginPeopleXMLParse.h"
#import "PaiGoHomePageController.h"

@interface PaiGoLoginController ()

@end
   
@implementation PaiGoLoginController

@synthesize EmailText,userpasswordText;

@synthesize login_userdata;

-(void)dealloc
{
    [login_userdata release];
    [EmailText release];
    [userpasswordText release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"登录";
    }
    return self;
}

- (void)viewDidLoad
{
    self.login_userdata =[[NSMutableArray alloc] init];
        
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(IBAction)LoginClick:(id)sender
{
    NSString *username=EmailText.text;
    NSString *userpassword=userpasswordText.text;
    if (login_data!=nil) {
        [login_data release];
    }
    if (login_url!=nil) {
         [login_url release];
    }
    NSString *loginurl = [NSString stringWithFormat:@"http://test.ksbtsoft.com/aocheng/trunk/restT/login.xml?username=%@&password=%@",username,userpassword];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:loginurl]];
    login_url = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    login_data=[[NSMutableData alloc] init];
}

-(IBAction)GoRegistBtnClick:(id)sender
{
    PaiGoRegistController *RegistController = [[PaiGoRegistController alloc] initWithNibName:@"PaiGoRegistController" bundle:nil];
    [self.navigationController pushViewController:RegistController animated:YES];
    
    [RegistController release];
}

-(IBAction)LoginViewclick:(id)sender
{
   [self.EmailText resignFirstResponder];
    [self.userpasswordText resignFirstResponder];
}

#pragma make NSURLCONNECTION
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
    [login_data appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
    if ([error code] == kCFURLErrorNotConnectedToInternet)
	{
        // if we can identify the error, we can present a more precise message to the user.
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"No Connection Error"
															 forKey:NSLocalizedDescriptionKey];
        NSError *noConnectionError = [NSError errorWithDomain:NSCocoaErrorDomain
														 code:kCFURLErrorNotConnectedToInternet
													 userInfo:userInfo];
        [self handleError:noConnectionError];
    }
	else
	{
        // otherwise handle the error generically
        [self handleError:error];
    }
    
    login_url = nil;
    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *returnString = [[NSString alloc] initWithData:login_data encoding:NSUTF8StringEncoding];
    
     ErrorBean *error=[[ErrorBean alloc] init];
    [LoginPeopleXMLParse parseArrXML:returnString commentArr:login_userdata errorBean:error];
    if ([error.status intValue]==0) {
        [self loginmessage:@"用户名或密码错误！"];
    }else if([error.status intValue]==1)
    {   
        [self.navigationController popViewControllerAnimated:YES];
        [self loginmessage:@"登录成功！"];
    }
    [returnString release];
    [error release];
}

- (void)loginmessage:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
														message:message
													   delegate:nil
											  cancelButtonTitle:@"确定"
											  otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}


- (void)handleError:(NSError *)error
{
    NSString *errorMessage = [error localizedDescription];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"网络连接异常"
														message:errorMessage
													   delegate:nil
											  cancelButtonTitle:@"确定"
											  otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
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
            EmailText = [[UITextField alloc] initWithFrame:CGRectMake(70, 12, 200, 24)];
            EmailText.delegate=self;
            EmailText.placeholder = @"输入邮箱地址";
            [cell addSubview:EmailText];
        }
        if (1 == indexPath.row) {
            cell.textLabel.text = @"密码:";
            cell.textLabel.textColor=[UIColor lightGrayColor];
            userpasswordText = [[UITextField alloc] initWithFrame:CGRectMake(70, 12, 200, 24)];
            userpasswordText.delegate=self;
            userpasswordText.placeholder = @"请输入密码";
            [cell addSubview:userpasswordText];
        }
    }
    
    return cell;
}
#pragma make - TextField

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
     
    [textField resignFirstResponder];
    return YES;
}

@end
