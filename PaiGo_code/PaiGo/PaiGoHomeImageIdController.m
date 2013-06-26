//
//  PaiGoHomeImageIdController.m
//  PaiGo
//
//  Created by apple  on 12-11-17.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import "PaiGoHomeImageIdController.h"
#import "ErrorBean.h"
#import "HomeImageIdBean.h"
#import "HomeImageIdXMLParse.h"
#import "asyncimageview.h"
#import "CouponDataBaseBean.h"
#import "HelpDataBase.h"


@interface PaiGoHomeImageIdController ()

@end

@implementation PaiGoHomeImageIdController

@synthesize nav_title;

@synthesize coup_id;
@synthesize productinfotableview;
@synthesize coup_url;
@synthesize coup_arry;
@synthesize coup_data;
@synthesize progressInd;
@synthesize expandedSections;
//@synthesize cellbutton;
@synthesize list_id;


-(void)dealloc
{
    [list_id release];
    [expandedSections release];
    [nav_title release];
    [progressInd release];
    [coup_arry release];
    [coup_data release];
    [coup_url release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    self.title=nav_title;
    coup_arry =[[NSMutableArray alloc] init];
    coup_data =[[NSMutableData alloc] init];
    if (!expandedSections)
    {
        expandedSections = [[NSMutableIndexSet alloc] init];
    }
    [self.progressInd startAnimating];
    [self product_id_urlconnection];
   // self.tabBarController.view.userInteractionEnabled = NO;
   // self.navigationController.navigationBar.userInteractionEnabled = NO;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)product_id_urlconnection
{
    NSString *product_url = [NSString stringWithFormat:@"http://test.ksbtsoft.com/aocheng/trunk/restT/couponsdetail.xml?coupid=%d",coup_id];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:product_url]];
    self.coup_url = [[[NSURLConnection alloc] initWithRequest:urlRequest delegate:self] autorelease];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark Table Delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger number=[self.coup_arry count];
    if (section==0)
    {
        return number;
    }else if(section==1)
    {
        return number;
    }else if(section==2)
    {
        if ([expandedSections containsIndex:section])
        {
            return number+1; // return rows when                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
        }
     return number;
    }else if(section==3)
    {
        return number;
    }
    return number;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *tableviewcell=nil;
    NSInteger ind= [indexPath section];
     NSString  *TableSampleIdentifier=@"TableSampleIdentifier";
    if(tableviewcell==nil)
    {
        tableviewcell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:TableSampleIdentifier] autorelease];
    }
    HomeImageIdBean *imagebean=[self.coup_arry objectAtIndex:0];
    if (ind==0 ) {
        if (indexPath.row==0){
               
        AsyncImageView *asyncimageview0= [[AsyncImageView alloc] initWithFrame:CGRectMake(0.0, 0.0,60.0, 60.0)];
        [asyncimageview0 loadImageFromURL:[NSURL URLWithString:imagebean.merchant_pic ] land:NO];
        [name_pic addSubview:asyncimageview0];
        name.text=imagebean.name;
        tableviewcell = cell0;
        [asyncimageview0 release];
        }
        
    }else if(ind==1)
    {
        if (indexPath.row==0)
        {
           phone.text= [NSString stringWithFormat:@"%d",imagebean.phone] ;
        }
        tableviewcell= cell1;
        
    }else if(ind==2){
    
        if (!indexPath.row)
        {
            if ([expandedSections containsIndex:indexPath.section])
            {
            }
            else
            {
                NSString *startdate=imagebean.start_time;
                NSString *enddate=imagebean.end_time;
                tite.text=imagebean.title;
                date.text=[NSString stringWithFormat:@"%@--%@",startdate, enddate];
                other.text=imagebean.other;
                [self textheight:imagebean.title datastring:[NSString stringWithFormat:@"%@--%@",startdate, enddate] otherstring:imagebean.other];
              tableviewcell= cell2;
            }
        }
        else
        {
            cell3.backgroundColor=[UIColor clearColor];
            UIView *code_pic=[[UIView alloc] initWithFrame:CGRectMake(50,3,80.0,80.0)];
            AsyncImageView *asyncimageview0= [[AsyncImageView alloc] initWithFrame:CGRectMake(50,3,80.0, 80.0)];
            [asyncimageview0 loadImageFromURL:[NSURL URLWithString:imagebean.name_pic ] land:NO];
            [code_pic addSubview:asyncimageview0];
            [cell3.contentView addSubview:code_pic];
            [code_pic release];
            [asyncimageview0 release];
            tableviewcell=cell3;
        }
    }else if(ind==3){
        if (indexPath.row==0)
            tableviewcell= cell4;
    }
    return tableviewcell;
}

-(float )textheight:(NSString *)titles datastring:(NSString *)datas otherstring:(NSString *)others
{
    HomeImageIdBean *imagebean=[self.coup_arry objectAtIndex:0];
    CGSize size = CGSizeMake(300.0, 1000);
    CGSize labelSizetitle = [titles sizeWithFont:tite.font constrainedToSize:size lineBreakMode:UILineBreakModeClip];
    tite.frame = CGRectMake(9, 46,tite.frame.size.width, labelSizetitle.height);
    
    CGSize labelSizedata1 = [date1.text sizeWithFont:date1.font constrainedToSize:size lineBreakMode:UILineBreakModeClip];
    date1.frame = CGRectMake(date1.frame.origin.x, tite.frame.origin.y+labelSizetitle.height,date1.frame.size.width, labelSizedata1.height);
    
    CGSize labelSizedata = [datas sizeWithFont:date.font constrainedToSize:size lineBreakMode:UILineBreakModeClip];
    date.frame = CGRectMake(date.frame.origin.x, tite.frame.origin.y+labelSizetitle.height,date.frame.size.width, labelSizedata.height);
    
    CGSize labelSizeother1 = [other1.text sizeWithFont:other1.font constrainedToSize:size lineBreakMode:UILineBreakModeClip];
    
    other1.frame = CGRectMake(other1.frame.origin.x, date.frame.origin.y+labelSizedata.height,other1.frame.size.width, labelSizeother1.height);
    
    CGSize labelSizeother = [others sizeWithFont:other.font constrainedToSize:size lineBreakMode:UILineBreakModeClip];
    
    other.frame = CGRectMake(other.frame.origin.x, date.frame.origin.y+labelSizedata.height,other.frame.size.width, labelSizeother.height);
    
    CGSize labelSizetext3 = [text3.text sizeWithFont:text3.font constrainedToSize:size lineBreakMode:UILineBreakModeClip];
    if([@"" isEqualToString:imagebean.other]) {
        text3.frame=CGRectMake(text3.frame.origin.x, other.frame.origin.y+labelSizeother1.height,text3.frame.size.width, labelSizetext3.height);
    }else {   
        text3.frame=CGRectMake(text3.frame.origin.x, other.frame.origin.y+labelSizeother.height,text3.frame.size.width, labelSizetext3.height);
    }

    CGSize labelSizetext4 = [text4.text sizeWithFont:text4.font constrainedToSize:size lineBreakMode:UILineBreakModeClip];
    text4.frame=CGRectMake(text4.frame.origin.x, text3.frame.origin.y+labelSizetext3.height,text4.frame.size.width, labelSizetext4.height);
    
    line.frame=CGRectMake(line.frame.origin.x, text4.frame.origin.y+labelSizetext4.height+5,line.frame.size.width, 1);
    
    pngzheng_pic.frame=CGRectMake(75, text4.frame.origin.y+labelSizetext4.height+9,139,23);
    
    fangxang_pic.frame=CGRectMake(222, text4.frame.origin.y+labelSizetext4.height+12,24,22);

    code.frame=CGRectMake(0, text4.frame.origin.y+labelSizetext4.height-5,300,42);
    height= code.frame.origin.y+labelSizetext4.height;
    return height;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger e=[indexPath section];
    if (e==0 ) {
        return 60;
    }else if(e==1)
    {
        return 40;
    }else if(e==2){
        if ([indexPath row]==0) {
            HomeImageIdBean *imagebean=[self.coup_arry objectAtIndex:0];
            NSString *startdate=imagebean.start_time;
            NSString *enddate=imagebean.end_time;
            date.text=[NSString stringWithFormat:@"%@--%@",startdate, enddate];
            [self textheight:imagebean.title datastring:[NSString stringWithFormat:@"%@--%@",startdate, enddate] otherstring:imagebean.other];
            float heights=[self textheight:imagebean.title datastring:[NSString stringWithFormat:@"%@--%@",startdate, enddate] otherstring:imagebean.other]+30;
            return heights;
        }else if([indexPath row]==1){
            return 90;
        }
    }else if(e==3){
        
        return 40;
    }
    
    return 30;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger section=[indexPath section];
    if (section==0) {
      
    }
    if (section==1) {
        HomeImageIdBean *imagebean=[self.coup_arry objectAtIndex:0];
        [self callphone:[NSString stringWithFormat:@"%d",imagebean.phone]];
    }else if(section==2){
       
    }else if (section==3) {
        HelpDataBase *helpdatabase=[[HelpDataBase alloc] init];
        CouponDataBaseBean *databasesbean=[[CouponDataBaseBean alloc] init];
        CouponDataBaseBean *databases=[[CouponDataBaseBean alloc] init];
        HomeImageIdBean *imagebean=[self.coup_arry objectAtIndex:0];
        NSMutableArray *couponarry=[[NSMutableArray alloc] init];
        BOOL d=NO;
        [helpdatabase queryTotable_id:couponarry];
        if ([couponarry count]==0) {
            databasesbean.name_coupon=imagebean.name;
            databasesbean.title_coupon=imagebean.title;
            databasesbean.address_coupon=imagebean.address;
            databasesbean.id_coupon=imagebean._id;
            [helpdatabase insertTotable:databasesbean];
            [helpdatabase queryTotable_id:couponarry];
            [self havemeassge:@"收藏优惠券成功"];
        }else{
            for (int i=0; i<[couponarry count]; i++) {
                databases=[couponarry objectAtIndex:i];
                
                if (databases.id_coupon==imagebean._id) {
                    [self havemeassge:@"优惠券已经存在"];
                    d=YES;
                    break;
                }
            }
            if (!d) {
                databasesbean.name_coupon=imagebean.name;
                databasesbean.title_coupon=imagebean.title;
                databasesbean.address_coupon=imagebean.address;
                databasesbean.id_coupon=imagebean._id;
                [helpdatabase insertTotable:databasesbean];
                [self havemeassge:@"收藏优惠券成功"];
            }
        }
        [helpdatabase release];
        [databasesbean release];
        [databases release];
    }

}

-(IBAction)cellbuttonclick:(id)sender
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:2];
    if (!indexPath.row)
    {
        [self.productinfotableview deselectRowAtIndexPath:indexPath animated:YES];
        NSInteger section = indexPath.section;
        BOOL currentlyExpanded = [expandedSections containsIndex:section];
        NSInteger rows;
        
        NSMutableArray *tmpArray = [NSMutableArray array];
        
        if (currentlyExpanded)
        {
            fangxang_pic.image=[UIImage imageNamed:@"arrow_down.png"];
            
            rows = [self tableView:self.productinfotableview numberOfRowsInSection:section];
            [expandedSections removeIndex:section];
        }
        else
        {
            fangxang_pic.image=[UIImage imageNamed:@"arrow_right.png"];
            
            [expandedSections addIndex:section];
            rows = [self tableView:self.productinfotableview numberOfRowsInSection:section];
        }
        
        for (int i=1; i<rows; i++)
        {
            NSIndexPath *tmpIndexPath = [NSIndexPath indexPathForRow:i inSection:section];
            [tmpArray addObject:tmpIndexPath];
        }
        if (currentlyExpanded)
        {
            [self.productinfotableview deleteRowsAtIndexPaths:tmpArray withRowAnimation:UITableViewRowAnimationTop];
        }
        else
        {
            [self.productinfotableview insertRowsAtIndexPaths:tmpArray withRowAnimation:UITableViewRowAnimationTop];
            
        }
         
    }

}

-(void)callphone:(NSString *)phones
{
    UIActionSheet *actionSheet = [[UIActionSheet  alloc] initWithTitle:nil
                                                              delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:phones otherButtonTitles:nil];
	actionSheet.actionSheetStyle = UIActionSheetStyleAutomatic;
	[actionSheet showFromTabBar:[self.tabBarController tabBar]];
	[actionSheet release];
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        HomeImageIdBean *imagebean=[self.coup_arry objectAtIndex:0];
        NSString *num = [[NSString alloc] initWithFormat:@"telprompt://%d",imagebean.phone];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]];
    }
}

- (void)havemeassge:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
														message:message
													   delegate:nil
											  cancelButtonTitle:@"确定"
											  otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}


#pragma make NSURLCONNECTION
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    return [self.coup_data appendData:data];
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
    
    self.coup_url = nil;
    
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    ErrorBean *error=[[ErrorBean alloc] init];
    NSString *home_imagecoup_returnString = [[NSString alloc] initWithData:self.coup_data encoding:NSUTF8StringEncoding];
    NSMutableArray *listdata=[[NSMutableArray alloc] init];
    [ HomeImageIdXMLParse parseArrXML:home_imagecoup_returnString commentArr:listdata errorBean:error];
    self.coup_arry=listdata;
    [self.productinfotableview reloadData];
    [self.progressInd stopAnimating];
    self.progressInd.hidden=YES;
    self.tabBarController.view.userInteractionEnabled = YES;
    self.navigationController.navigationBar.userInteractionEnabled = YES;
    [home_imagecoup_returnString release];
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




@end
