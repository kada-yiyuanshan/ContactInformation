//
//  PaiGoNearController.m
//  PaiGo
//
//  Created by apple  on 12-10-16.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import "PaiGoNearController.h"
#import "ErrorBean.h"
#import "NearBean.h"
#import "NearXMLParse.h"

@interface PaiGoNearController ()

@end

@implementation PaiGoNearController

@synthesize DistanceBtn,ClassBtn,SortBtn;
@synthesize OkButton,CancelButton;
@synthesize actionSheet;
@synthesize MyDistanceArray,MyClassArray,MySortArray;
@synthesize MyDistancePickerView,MyClassPickerView, MySortPickerView;
@synthesize MyDistanceSheettext,MyClassSheettext,MySortSheettext;;
@synthesize DistanceBtntitle,ClassBtntitle,SortBtntitle;
@synthesize returnStr;
@synthesize near_array;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"附近";
    }
    return self;
}
-(void)dealloc
{
    [near_array release];
    [returnStr release];
    [MySortArray release];
    [MyClassArray release];
    [MyDistanceArray release];
    [MyClassPickerView release];
    [MyDistancePickerView release];
    [MySortPickerView release];
    [MyDistanceSheettext release];
    [MyClassSheettext release];
    [MySortSheettext release];
    [actionSheet release];
    [DistanceBtn release];
    [ClassBtn release];
    [SortBtn release];
    [DistanceBtntitle release];
    [ClassBtntitle release];
    [SortBtntitle release];
    [super dealloc];
}
- (void)viewDidLoad
{
    self.near_array=[[NSMutableArray alloc] init];
    NSString *nearstring_url = [NSString stringWithFormat:@"http://test.ksbtsoft.com/aocheng/trunk/restT/searchmerchantsbydistance.xml?longitude=120.2&latitude=30.2&distances=500&order=created"];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:nearstring_url]];
    near_url = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    near_data =[[NSMutableData alloc] init];
    [progressInd startAnimating];
    
    NSArray *dis=[[NSArray alloc] initWithObjects:@"0.5公里",@"1.0公里",@"2.0公里",@"3.0公里", nil];
    self.MyDistanceArray=dis;
    
    NSArray *class=[[NSArray alloc] initWithObjects:@"美食",@"生活服务",@"休闲娱乐",@"美容美体",@"运动健身",@"酒店",@"汽车",@"房产", nil];
    self.MyClassArray=class;
    
    NSArray *sort=[[NSArray alloc] initWithObjects:@"最热门",@"最新发布", nil];
    self.MySortArray=sort;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavigationBarbackground.png"] forBarMetrics:UIBarMetricsDefault];
    [DistanceBtn setImage:[UIImage imageNamed:@"arrow_detail.png"] forState:UIControlStateNormal];
    [DistanceBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0, 62.0, 0,0)];
    [DistanceBtn setTitle:@"距离" forState:UIControlStateNormal];
    [DistanceBtn setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 30.0)];
    
    [ClassBtn setImage:[UIImage imageNamed:@"arrow_detail.png"] forState:UIControlStateNormal];
    [ClassBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0, 62.0, 0,0)];
    [ClassBtn setTitle:@"分类" forState:UIControlStateNormal];
    [ClassBtn setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 30.0)];
    
    [SortBtn setImage:[UIImage imageNamed:@"arrow_detail.png"] forState:UIControlStateNormal];
    [SortBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0, 62.0, 0,0)];
    [SortBtn setTitle:@"排序" forState:UIControlStateNormal];
    [SortBtn setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 30.0)];
    [dis release];
    [class release];
    [sort release];
    [super viewDidLoad];
   
}

- (void)viewDidUnload
{   returnStr=nil;
    [super viewDidUnload];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
}
-(void)near_urlconnection:(NSString *)distances neartype:(NSInteger)type nearorder:(NSString *)order
{
    if (near_url!=nil) {
        [near_url release];
    }
    if (near_data!=nil) {
        [near_data release];
    }
    NSString *nearstring_url=nil ;
    if ([@"" isEqualToString:order]&& ![@"" isEqualToString:distances]) {
     nearstring_url = [NSString stringWithFormat:@"http://test.ksbtsoft.com/aocheng/trunk/restT/searchmerchants.xml?longitude=120.2&latitude=30.2&distances=%@&type=%d&order=created",distances,type];
    }else if([@"" isEqualToString:distances]&& ![@"" isEqualToString:order])
    {
      nearstring_url = [NSString stringWithFormat:@"http://test.ksbtsoft.com/aocheng/trunk/restT/searchmerchants.xml?longitude=120.2&latitude=30.2&distances=3.0&type=%d&order=%@",type,order];
    }else if([@"" isEqualToString:order]&& [@"" isEqualToString:distances]){
      nearstring_url = [NSString stringWithFormat:@"http://test.ksbtsoft.com/aocheng/trunk/restT/searchmerchants.xml?longitude=120.2&latitude=30.2&distances=3.0&type=%d&order=created",type];
    }else{
       nearstring_url = [NSString stringWithFormat:@"http://test.ksbtsoft.com/aocheng/trunk/restT/searchmerchants.xml?longitude=120.2&latitude=30.2&distances=%@&type=%d&order=%@",distances,type,order];
    }
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:nearstring_url]];
    near_url = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    near_data =[[NSMutableData alloc] init];
    [progressInd startAnimating];
    //NSLog(@"nearstring_url=%@",nearstring_url);
}
-(void)near_urlconnection:(NSString *)distances
{
    if (near_url!=nil) {
        [near_url release];
    }
    if (near_data!=nil) {
        [near_data release];
    }
    NSString *distancestring_url = [NSString stringWithFormat:@"http://test.ksbtsoft.com/aocheng/trunk/restT/searchmerchantsbydistance.xml?longitude=120.2&latitude=30.2&distances=%@&type=&order=created",distances];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:distancestring_url]];
    near_url = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    near_data =[[NSMutableData alloc] init];
    [progressInd startAnimating];
   // NSLog(@"distancestring_url#####=%@",distancestring_url);

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(IBAction)DistanceBtnclick:(id)sender{
    DistanceBtntitle=[sender titleForState:UIControlStateNormal];
    tag=DistanceBtn.tag;
    [self ShowSheet:MyDistancePickerView];
    }
-(IBAction)ClassBtnclick:(id)sender
{   tag=ClassBtn.tag;
    
    ClassBtntitle=[sender titleForState:UIControlStateNormal];
   [self ShowSheet:MyClassPickerView];
}
-(IBAction)SortBtnclick:(id)sender
{   tag=SortBtn.tag;
    SortBtntitle=[sender titleForState:UIControlStateNormal];
   [self ShowSheet:MySortPickerView];
}
-(IBAction)OkButtonclick:(id)sender
{
    NSString *neworder=nil;
    distance = [MyDistanceSheettext substringToIndex:3];
    if ( [@"最热门" isEqualToString:MySortSheettext]) {
        neworder=@"count";
    }else if([@"最新发布" isEqualToString:MySortSheettext]){
        neworder=@"created";
    }
    switch (tag) {
        case 1:
            if (MyDistanceSheettext==nil) {
                [DistanceBtn setTitle:@"距离" forState:UIControlStateNormal];
            }
            else
            {
                if (MyDistanceSheettext==DistanceBtntitle) {
                }
                else
                {
                    if (b_near==YES) {
                        if (neworder==NULL) {
                            [self near_urlconnection:distance neartype:texttypes+1 nearorder:@""];
                        }else{
                            [self near_urlconnection:distance neartype:texttypes+1 nearorder:neworder];
                        }
                    }else{
                        [self near_urlconnection:distance];
                    }
                    [DistanceBtn setTitle:MyDistanceSheettext forState:UIControlStateNormal];
                }
            }
            break;
        case 2:
            if (MyClassSheettext==nil) {
                [ClassBtn setTitle:@"分类" forState:UIControlStateNormal];
            }
            else
            {
                int n=0;
                for (int i=0;i<[self.MyClassArray count]; i++) {
                    if ([self.MyClassArray objectAtIndex:i]==MyClassSheettext) {
                        n=i;
                        break;
                    }
                }
                texttypes=n;
                if (MyClassSheettext==ClassBtntitle) {
                    
                }
                else
                { 
                    if (neworder==NULL) {
                        if (distance==NULL) {
                            [self near_urlconnection:@"" neartype:n+1 nearorder:@""];
                        }else{
                            [self near_urlconnection:distance neartype:n+1 nearorder:@""];
                        }
                    }else
                    {
                        if (distance==NULL) {
                            [self near_urlconnection:@"" neartype:texttypes+1 nearorder:neworder];
                        }else{
                            [self near_urlconnection:distance neartype:texttypes+1 nearorder:neworder];
                        }
                    }
                    [ClassBtn setTitle:MyClassSheettext forState:UIControlStateNormal];
                }
            }
            b_near=YES;
           break;
        case 3:
            
            if (MySortSheettext==nil) {
                [SortBtn setTitle:@"排序" forState:UIControlStateNormal];
            }
            else
            {
                if (MySortSheettext==SortBtntitle) {
                }
                else
                {
                    if (distance==NULL) {
                        [self near_urlconnection:@"" neartype:texttypes+1 nearorder:neworder];
                    }else{
                        [self near_urlconnection:distance neartype:texttypes+1 nearorder:neworder];
                    }
                    [SortBtn setTitle:MySortSheettext forState:UIControlStateNormal];
                }
            }
            b_near=YES;
            break;
        default:
            break;
    }
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}
-(IBAction)CancelButtonclick:(id)sender
{
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}

-(void)ShowSheet:(UIPickerView *)pickerView
{
    NSString *title = UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation) ? @"\n\n\n\n\n\n\n\n\n" : @"\n\n\n\n\n\n\n\n\n\n\n\n" ;
    actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    [actionSheet  showFromTabBar:[self.tabBarController tabBar]];
    switch (tag) {
        case 1:
            if (pickerView==MyDistancePickerView) {
                MyDistancePickerView =  [[[UIPickerView   alloc] initWithFrame:CGRectMake(0, 40, 320, 215)] autorelease];
                MyDistancePickerView.delegate = self;
                MyDistancePickerView.dataSource =self;
                MyDistancePickerView.showsSelectionIndicator  =  YES ;
                MyDistanceSheettext=[MyDistanceArray objectAtIndex:0];
                [actionSheet addSubview:MyDistancePickerView];
            }
            break;
         case 2:
            if (pickerView==MyClassPickerView) {
                MyClassPickerView =  [[[UIPickerView   alloc] initWithFrame:CGRectMake(0, 40, 320, 215)] autorelease];
                MyClassPickerView.delegate = self;
                MyClassPickerView.dataSource = self;
                MyClassPickerView.showsSelectionIndicator  =  YES ;
                MyClassSheettext=[MyClassArray objectAtIndex:0];
                [actionSheet addSubview:MyClassPickerView];
            }
            break;
         case 3:
            if (pickerView==MySortPickerView) {
                MySortPickerView =  [[[UIPickerView   alloc] initWithFrame:CGRectMake(0, 40, 320, 215)] autorelease];
                MySortPickerView.delegate = self;
                MySortPickerView.dataSource = self;
                MySortPickerView.showsSelectionIndicator  =  YES ;
                MySortSheettext=[MySortArray objectAtIndex:0];
                [actionSheet addSubview:MySortPickerView];
            }
            break;
        default:
            break;
    }
        CGRect frame1=CGRectMake(10, 8, 75, 29);
    CancelButton=[UIButton buttonWithType:UIButtonTypeCustom];
    CancelButton.frame=frame1;
    [CancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [CancelButton setBackgroundImage:[[UIImage imageNamed:@"dialog_button_normal.png"]stretchableImageWithLeftCapWidth:12 topCapHeight:0] forState:UIControlStateNormal];
    [CancelButton setBackgroundImage:[[UIImage imageNamed:@"dialog_button_active.png"]stretchableImageWithLeftCapWidth:12 topCapHeight:0] forState:UIControlStateHighlighted];
    [CancelButton addTarget:self action:@selector(CancelButtonclick:) forControlEvents:UIControlEventTouchUpInside];
    
    [actionSheet addSubview:CancelButton ];
    
    CGRect frame2=CGRectMake(230, 8, 75, 29);
    OkButton=[UIButton buttonWithType:UIButtonTypeCustom];
    OkButton.frame=frame2;
    [OkButton setTitle:@"确定" forState:UIControlStateNormal];
    [OkButton setBackgroundImage:[[UIImage imageNamed:@"dialog_button_normal.png"]stretchableImageWithLeftCapWidth:12 topCapHeight:0] forState:UIControlStateNormal];
    [OkButton setBackgroundImage:[[UIImage imageNamed:@"dialog_button_active.png"]stretchableImageWithLeftCapWidth:12 topCapHeight:0] forState:UIControlStateHighlighted];
    [OkButton addTarget:self action:@selector(OkButtonclick:) forControlEvents:UIControlEventTouchUpInside];
    [actionSheet addSubview:OkButton ];
    [actionSheet  showFromTabBar:[self.tabBarController tabBar]];
    [CancelButton release];
    [OkButton release];

}
#pragma mark -
#pragma mark UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	if (pickerView == MyDistancePickerView)	
	{
        MyDistanceSheettext=[MyDistanceArray objectAtIndex:[pickerView selectedRowInComponent:0]];
	}
    if (pickerView == MyClassPickerView)
    {
        MyClassSheettext=[MyClassArray objectAtIndex:[pickerView selectedRowInComponent:0]];
    }
    if (pickerView == MySortPickerView)
    {
        MySortSheettext=[MySortArray objectAtIndex:[pickerView selectedRowInComponent:0]];
    }
}

#pragma mark -
#pragma mark UIPickerViewDataSource

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{

    
	if (component==0) {
        if (pickerView==MyDistancePickerView) {
           returnStr = [MyDistanceArray objectAtIndex:row];
        }
        if (pickerView==MyClassPickerView) {
            returnStr = [MyClassArray objectAtIndex:row];
        }
        if (pickerView==MySortPickerView) {
            returnStr = [MySortArray objectAtIndex:row];
        }
    }
    else
    {
        returnStr = [[NSNumber numberWithInt:row] stringValue];
    }
	return returnStr;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
	CGFloat componentWidth = 0.0;
    
	if (component == 0)
		componentWidth = 300.0;	// first column size is wider to hold names
	else
		componentWidth = 40.0;	// second column is narrower to show numbers
    
	return componentWidth;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
	return 40.0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger countnumber=0;
    if (pickerView==MyDistancePickerView) {
        countnumber=[MyDistanceArray count];
    }
	if (pickerView==MyClassPickerView) {
        countnumber=[MyClassArray count];
    }
    if (pickerView==MySortPickerView) {
        countnumber=[MySortArray count];
    }
    return countnumber;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}

#pragma make TABLEVIEW

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [near_array count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString  *TableSampleIdentifier=@"TableSampleIdentifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier: TableSampleIdentifier];
    if(cell==nil)
    {
        cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                     reuseIdentifier:TableSampleIdentifier] autorelease];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSInteger row=[indexPath row];
    
    NearBean *nearbean=[self.near_array objectAtIndex:row];
    cell.textLabel.text=nearbean.near_name;
    cell.detailTextLabel.text=[NSString stringWithFormat:@"%.1lf",nearbean.near_distance] ;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma make NSURLCONNECTION
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    return [near_data appendData:data];
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
        [self handleError:error];
    }
    
    near_url = nil;
    
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    ErrorBean *error=[[ErrorBean alloc] init];
    NSString *near_returnString = [[NSString alloc] initWithData:near_data encoding:NSUTF8StringEncoding];
    NSMutableArray *listdata=[[NSMutableArray alloc] init];
    [ NearXMLParse parseArrXML:near_returnString commentArr:listdata errorBean:error];
    self.near_array=listdata;
    NSSortDescriptor* sortByA = [NSSortDescriptor sortDescriptorWithKey:@"near_distance" ascending:YES];
    [self.near_array sortUsingDescriptors:[NSArray arrayWithObject:sortByA]];
    [near_tableview reloadData];
    message=error.errorMessage;
    if ([@"附近没有优惠券商家" isEqualToString:message]) {
        [self havemessage:message];
    }
    [progressInd stopAnimating];
    progressInd.hidden=YES;
    [near_returnString release];
    self.tabBarController.view.userInteractionEnabled = YES;
    self.navigationController.navigationBar.userInteractionEnabled = YES;
    
    [listdata release];
    [error release];
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

- (void)havemessage:(NSString *)messages
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"拍Go提示"
														message:messages
													   delegate:nil
											  cancelButtonTitle:@"确定"
											  otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}

@end
