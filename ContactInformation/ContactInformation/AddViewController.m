//
//  AddViewController.m
//  ContactInformation
//
//  Created by apple  on 12-10-31.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import "AddViewController.h"
#import "ContactInformationViewController.h"
#import "DataBaseBean.h"
#import "HelpDataBase.h"
#import "ContactInformationAppDelegate.h"
#import "MapViewController.h"

@interface AddViewController ()

@end
   
@implementation AddViewController


@synthesize firstname,lastname,phone,email,address;
@synthesize b_Edit;
@synthesize gendersegment;
@synthesize segmentindex;  
@synthesize keyBoardMargin_;
@synthesize firstlable,lastlable,genderlable,phonelable,emaillable,addresslable;
@synthesize sendemail,mapview;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       self.navigationItem.title = @"Information";
    }
    return self;
}

-(void)dealloc
{
    [firstlable release];
    [lastlable release];
    [genderlable release];
    [phonelable release];
    [emaillable release];
    [addresslable release];
    [gendersegment release];
    [firstname release];
    [lastname release];
    [phone release];
    [email release];
    [address release];
    
    [super dealloc];
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        [_detailItem release];
        _detailItem = [newDetailItem retain];
        }
}

-(void)viewDidLoad
{
    [self textalloc];
    if (b_Edit==NO) {
        UIBarButtonItem *rightbutton3=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveclick:)];
        gendersegment.selectedSegmentIndex = 0;
        self.navigationItem.rightBarButtonItem =rightbutton3;
        [rightbutton3 release];
        [self textsetenabledYES];
    }else if (b_Edit==YES) {
        self.navigationItem.rightBarButtonItem=self.editButtonItem;
        [self textsetenabledNO];
        [self textfieldcolorblack];
        [self labletextcolorblack];
        }
    [self readdata];
    
    [super viewDidLoad];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    
    [super setEditing:editing animated:animated];
    
    UIBarButtonItem *rightbutton2=[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(updataclick:)] autorelease];
    if (editing) {
        [self textsetenabledYES];
        self.navigationItem.rightBarButtonItem =rightbutton2;
    }
}

-(void)readdata
{
    DataBaseBean *databasebean = [[DataBaseBean alloc] init];
    
    if (self.detailItem) {
        databasebean=self.detailItem;
        firstname.text=databasebean.firstname;
        lastname.text=databasebean.lastname;
        if ([@"male" isEqual:databasebean.gender]) {
            gendersegment.selectedSegmentIndex = 0;
            [self.gendersegment setTitle: databasebean.gender forSegmentAtIndex:0];
            
        }
        else if([@"female" isEqual:databasebean.gender]){
            gendersegment.selectedSegmentIndex = 1;
            [self.gendersegment setTitle: databasebean.gender forSegmentAtIndex:1];
        }
        phone.text=[NSString stringWithFormat:@"%d",databasebean.phone];
        email.text=databasebean.email;
        address.text=databasebean.address;
    }
    [databasebean release];

}

-(IBAction)saveclick:(id)sender
{
  
    DataBaseBean *databasebean = [[DataBaseBean alloc] init];
    HelpDataBase *helpdatabase = [[HelpDataBase alloc] init];
    if ( [@"" isEqualToString:firstname.text] || firstname.text== NULL) {
        [self iffirstnameNull];          
    }else
    {
        databasebean.firstname=firstname.text;
        databasebean.lastname=lastname.text;
        segmentindex=gendersegment.selectedSegmentIndex;
        if (segmentindex==0) {
            databasebean.gender=@"male";
        }else if(segmentindex==1)
        {
            databasebean.gender=@"female";
        }
        databasebean.phone=[phone.text integerValue];
        
        databasebean.email=email.text;
        databasebean.address=address.text;
        [helpdatabase insertTotable:databasebean];
        [self.navigationController popViewControllerAnimated:YES];

        
    }
    
    [databasebean release];
    [helpdatabase release];
    
}

-(IBAction)updataclick:(id)sender
{
    DataBaseBean *databasebean = [[DataBaseBean alloc] init];
     HelpDataBase *helpdatabase = [[HelpDataBase alloc] init];
    if (self.detailItem) {
        
        if ([@"" isEqualToString:firstname.text] || firstname.text== NULL)
        {
            [self iffirstnameNull]; 
        }
        else
        {
            databasebean=self.detailItem;
            databasebean.firstname=firstname.text;
            databasebean.lastname=lastname.text;
            segmentindex=gendersegment.selectedSegmentIndex;
            if (segmentindex==0) {
                databasebean.gender=@"male";
            }else if(segmentindex==1)
            {
                databasebean.gender=@"female";
            }
            databasebean.phone=[phone.text integerValue];
            databasebean.email=email.text;
            databasebean.address=address.text;
            [helpdatabase updateTotable:databasebean];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    [databasebean release];
    [helpdatabase release];

}

-(void)textalloc
{
    CGRect frame=CGRectMake(100, 2, 150, 40);
    gendersegment=[[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"male",@"female", nil]];
    gendersegment.segmentedControlStyle=UISegmentedControlStylePlain;
    gendersegment.selected=YES;   
    gendersegment.frame=frame;
    genderlable=[[UILabel alloc]initWithFrame:CGRectMake(20, 12, 80, 24)];
    genderlable.backgroundColor=[UIColor clearColor];

    firstname = [[UITextField alloc] initWithFrame:CGRectMake(110, 12, 200, 24)];
    firstname.delegate=self;
    firstlable=[[UILabel alloc]initWithFrame:CGRectMake(20, 12, 85, 24)];
    firstlable.backgroundColor=[UIColor clearColor];
   
    lastname = [[UITextField alloc] initWithFrame:CGRectMake(110, 12, 200, 24)];
    lastname.delegate=self;
    lastlable=[[UILabel alloc]initWithFrame:CGRectMake(20, 12, 80, 24)];
    lastlable.backgroundColor=[UIColor clearColor];
   
    phone = [[UITextField alloc] initWithFrame:CGRectMake(90, 12, 200, 24)];
    phone.delegate=self;
    phonelable=[[UILabel alloc]initWithFrame:CGRectMake(20, 12, 80, 24)];
    phonelable.backgroundColor=[UIColor clearColor];
    
    email = [[UITextField alloc] initWithFrame:CGRectMake(90, 12, 190, 24)];
    email.delegate=self;
    emaillable=[[UILabel alloc]initWithFrame:CGRectMake(20, 12, 80, 24)];
    emaillable.backgroundColor=[UIColor clearColor];
   
    address = [[UITextField alloc] initWithFrame:CGRectMake(90, 12, 200, 24)];
    address.delegate=self;
    addresslable=[[UILabel alloc]initWithFrame:CGRectMake(20, 12, 80, 24)];
    addresslable.backgroundColor=[UIColor clearColor];
   
}

-(void)textsetenabledNO
{
     [firstname setEnabled:NO];
     [lastname setEnabled:NO];
     [phone setEnabled:NO];
     [email setEnabled:NO];
     [address setEnabled:NO];
     [gendersegment setEnabled:NO];
    
}

-(void)textsetenabledYES
{    
    [firstname setEnabled:YES];
    
    [lastname setEnabled:YES];
    [phone setEnabled:YES];
    [email setEnabled:YES];
    [address setEnabled:YES];
    [gendersegment setEnabled:YES];
    
}

-(void)textfieldcolorblack
{
    firstname.textColor=[UIColor blackColor];
    lastname.textColor=[UIColor blackColor];
    phone.textColor=[UIColor blackColor];
    email.textColor=[UIColor blackColor];
    address.textColor=[UIColor blackColor];
    
}

-(void)labletextcolorblack
{
    firstlable.textColor=[UIColor blackColor];
    lastlable.textColor=[UIColor blackColor];
    phonelable.textColor=[UIColor blackColor];
    emaillable.textColor=[UIColor blackColor];
    addresslable.textColor=[UIColor blackColor];
    genderlable.textColor=[UIColor blackColor];
}


-(IBAction)backgroundclick:(id)sender
{

    [firstname resignFirstResponder];
    [lastname resignFirstResponder];
    [phone resignFirstResponder];
    [email resignFirstResponder];
    [address resignFirstResponder];

}

-(void)iffirstnameNull
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Firstname can not be null"
                                                   delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
	[alert show];
	[alert release];
}


- (void)viewDidUnload
{
    firstname=nil;
    lastname=nil;
    phone=nil;
    email=nil;
    address=nil;
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)mapviewclick:(id)sender
{
    MapViewController *mapviewcontroller = [[MapViewController alloc ] initWithNibName:@"MapViewController" bundle:nil];
    mapviewcontroller.address=address.text;
    [self.navigationController pushViewController:mapviewcontroller animated:YES];
    [mapviewcontroller release];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    if (0 == [indexPath section]) {
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        if (0 == indexPath.row) {
            firstlable.text=@"Firstname:";
            [firstname setPlaceholder:@"Firstname can not be null"];
            [cell addSubview:firstlable];
            [cell addSubview:firstname];
        }
        if (1 == indexPath.row) {
            lastlable.text = @"Lastname:";
            [cell addSubview:lastlable];
            [cell addSubview:lastname];
        }
        if (2 == indexPath.row) {
            genderlable.text = @"Gender:";
            [cell addSubview:genderlable];
            [cell addSubview:gendersegment];
        }
        if (3 == indexPath.row) {
            phonelable.text = @"Phone:";
            [phone setKeyboardType:UIKeyboardTypePhonePad];
            [cell addSubview:phonelable];
            [cell addSubview:phone];
        }
        if (4 == indexPath.row) {
            emaillable.text = @"Email:";
                        if (b_Edit==NO) {
            } else if(b_Edit==YES){
                CGRect emailframe=CGRectMake(270, 5.0, 40,40);
                sendemail=[UIButton buttonWithType:UIButtonTypeDetailDisclosure];
                sendemail.frame=emailframe;
                [sendemail addTarget:self action:@selector(sendEmail:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:sendemail];
            }
            [cell addSubview:emaillable];
            [cell addSubview:email];
        }
        if (5 == indexPath.row) {
            addresslable.text = @"Address:";
                        if (b_Edit==NO) {
            } else if(b_Edit==YES){
                CGRect mapframe=CGRectMake(270, 5.0, 40,40);
                mapview=[UIButton buttonWithType:UIButtonTypeDetailDisclosure];
                mapview.frame=mapframe;
                [mapview addTarget:self action:@selector(mapviewclick:)forControlEvents:UIControlEventTouchUpInside];
                [cell addSubview:mapview];
            }
            [cell addSubview:addresslable];
            [cell addSubview:address];
        }
                
    }
    
    return cell;
}
- (IBAction)sendEmail:(id)sender
{
    MFMailComposeViewController *mailCompose = [[MFMailComposeViewController alloc] init];
    if(mailCompose)   
    {
        //set delegate
        [mailCompose setMailComposeDelegate:self];
        NSArray *toAddress = [NSArray arrayWithObject:email.text];
        NSArray *ccAddress = [NSArray arrayWithObject:email.text];
        NSString *emailBody = phone.text;
    
        [mailCompose setToRecipients:toAddress];
      
        [mailCompose setCcRecipients:ccAddress];
        
        [mailCompose setMessageBody:emailBody isHTML:YES];
     
        [mailCompose setSubject:address.text];
    
        [self presentModalViewController:mailCompose animated:YES];
    }
    [mailCompose release];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    //    message.hidden = NO;
    // Notifies users about errors associated with the interface
    switch (result)
    {
        case MFMailComposeResultCancelled:
            [self messagtitle:@"Delete" message:@"success !"];
            break;
        case MFMailComposeResultSaved:
            [self messagtitle:@"Save" message:@"success !"];
           
            break;
        case MFMailComposeResultSent:
           [self messagtitle:@"Sent" message:@"success !"];
            
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Failed");
          
            break;
        default:
        
            break;
    }
    [self dismissModalViewControllerAnimated:YES];
}

-(void)messagtitle:(NSString *)title message:(NSString *)messages
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:messages
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
}

#pragma make - TextField


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{

    [textField resignFirstResponder];
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
   [self moveView:textField leaveView:NO]; 
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
   [self moveView:textField leaveView:YES];
}
#pragma make  keyboard

- (void)moveView:(UITextField *)textField leaveView:(BOOL)leave
{
    float screenHeight = 480; //screen size
    float keyboardHeight = 216; //keyboard size
    float statusBarHeight,NavBarHeight,tableCellHeight,textFieldOriginY,textFieldFromButtomHeigth;
    int margin;
    statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    NavBarHeight = self.navigationController.navigationBar.frame.size.height;
    
    UITableViewCell *tableViewCell=(UITableViewCell *)textField.superview;
    tableCellHeight = tableViewCell.frame.size.height+tableViewCell.frame.size.height;
    
    CGRect fieldFrame=[self.view convertRect:textField.frame fromView:tableViewCell];
    textFieldOriginY = fieldFrame.origin.y;
    
    textFieldFromButtomHeigth = screenHeight - statusBarHeight - NavBarHeight - textFieldOriginY - tableCellHeight;
    
    if(!leave) {
        if(textFieldFromButtomHeigth < keyboardHeight) {
            margin = keyboardHeight - textFieldFromButtomHeigth;
            keyBoardMargin_ = margin;
        } else {
            margin= 0;
            keyBoardMargin_ = 0;
        }
    }
    const float movementDuration = 0.4f;
    
    int movement = (leave ? keyBoardMargin_ : -margin);
    
    [UIView beginAnimations: @"textFieldAnim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}



@end
