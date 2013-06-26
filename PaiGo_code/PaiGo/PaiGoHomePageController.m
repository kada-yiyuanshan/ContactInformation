//
//  PaiGoHomePageController.m
//  PaiGo
//
//  Created by apple  on 12-10-11.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import "PaiGoHomePageController.h"
#import "PaiGoLoginController.h"
#import "PaiGoAppDelegate.h"
#import "PaiGoHomeTableViewItemController.h"
#import "ShouYeImageXMLParse.h"
#import "ErrorBean.h"
#import "asyncimageview.h"
#import "ShouYeImageBean.h"
#import "ShouYeClassBean.h"
#import "ShouYeClassXMLParse.h"
#import "PaiGoSearchResultController.h"
#import "PaiGoHomeImageController.h"
#import "PaiGoStoreViewController.h"

@interface PaiGoHomePageController ()

@end

@implementation PaiGoHomePageController

@synthesize searchbar;
@synthesize classdata;
@synthesize hometableview;
@synthesize imagedata;
@synthesize viewimage0;
@synthesize viewimage1;
@synthesize viewimage2;
@synthesize login_status;
@synthesize progressInd;

-(void)dealloc
{
    
    [progressInd release];
    [viewimage0 release];
    [viewimage1 release];
    [viewimage2 release];
    [imagedata release];
    [searchbar release];
    [classdata release];
    [hometableview release];
   
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"首页", @"首页");
    }
    
    return self;
}

- (void)viewDidLoad
{   
    self.imagedata=[[NSMutableArray alloc] init];
    self.classdata=[[NSMutableArray alloc] init];
    
   
    [self loginbutton];
     hometableview.layer.cornerRadius=8;
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
//        self.tabBarController.view.userInteractionEnabled = NO;
//        self.navigationController.navigationBar.userInteractionEnabled = NO;
    
        [self image_urlconnection];
        [self class_urlconnection];
}
-(void)image_urlconnection
{
    if (shouyeimage_url!=nil) {
        [shouyeimage_url release];
    }
        if (listdata_shouye_image!=nil) {
        [listdata_shouye_image release];
    }
        static  NSString  *topimage=@"http://test.ksbtsoft.com/aocheng/trunk/restT/merchantpic.xml?limit=6&order=";
        NSURLRequest *image_urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:topimage]];
        shouyeimage_url= [[NSURLConnection alloc] initWithRequest:image_urlRequest delegate:self];
        listdata_shouye_image=[[NSMutableData alloc] init];
        [self.progressInd startAnimating];
}

-(void)class_urlconnection
{
    if (shouyeclass_url!=nil) {
        [shouyeclass_url release];
    }
  
    if (listdata_shouye_class!=nil) {
        [listdata_shouye_class release];
    }
        static NSString *classname=@"http://test.ksbtsoft.com/aocheng/trunk/restT/listmerchanttypes.xml?p_id=0&limit=8&order=";
        NSURLRequest *class_urlRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:classname]];
        shouyeclass_url=[[NSURLConnection alloc] initWithRequest:class_urlRequest delegate:self];
        listdata_shouye_class=[[NSMutableData alloc] init];
        //[self.progressInd startAnimating];
}

-(void)loginbutton
{
    if (login_status==NO){
        
    }else if(login_status==YES) {
        UIBarButtonItem *Login=[[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStyleBordered target:self action:@selector(TabBarLogin:)];
        self.navigationItem.rightBarButtonItem=Login;
        [Login release];
    }
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavigationBarbackground.png"] forBarMetrics:UIBarMetricsDefault];
    

}
- (void)viewDidUnload
{
    
    [super viewDidUnload];
}
-(void)viewDidAppear:(BOOL)animated
{
    [self.progressInd startAnimating];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(IBAction)TabBarLogin:(id)sender
{
    PaiGoLoginController *LoginController = [[PaiGoLoginController alloc] initWithNibName:@"PaiGoLoginController" bundle:nil];
    [self.navigationController pushViewController:LoginController animated:NO];
    [LoginController release];
}

#pragma mark -
#pragma mark Table Delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.classdata count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString  *TableSampleIdentifier=@"TableSampleIdentifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    
    if(cell==nil)
    {
        cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                    reuseIdentifier:TableSampleIdentifier] autorelease];
       
    }
     NSInteger row=[indexPath row];
    
    ShouYeClassBean *shouyeclass=[self.classdata objectAtIndex:row];
    cell.textLabel.text=shouyeclass.name;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    

    switch (indexPath.row)
    {
        case 0:
            cell.imageView.image = [UIImage imageNamed:@"main_meishi.png"];
            break;
        case 1:
            cell.imageView.image = [UIImage imageNamed:@"main_shenghuo.png"];
            break;            
        case 2:
            cell.imageView.image = [UIImage imageNamed:@"main_xiuxian.png"];
            break;
        case 3:
            cell.imageView.image = [UIImage imageNamed:@"main_meirong.png"];
            break;
        case 4:
            cell.imageView.image = [UIImage imageNamed:@"main_yundong.png"];
            break;
        case 5:
            cell.imageView.image = [UIImage imageNamed:@"main_jiudian.png"];
            break;
        case 6:
            cell.imageView.image = [UIImage imageNamed:@"main_qiche.png"];
            break;
        case 7:
            cell.imageView.image = [UIImage imageNamed:@"main_fangchan.png"];
            break;
        default:
            break;
    }
    
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   return indexPath;
}
-(void)jump
{
    PaiGoHomeTableViewItemController *HomeTableViewItemController = [[PaiGoHomeTableViewItemController alloc] initWithNibName:@"PaiGoHomeTableViewItemController" bundle:nil];
    [self.navigationController pushViewController:HomeTableViewItemController animated:YES];
      [HomeTableViewItemController release];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 35;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = [NSArray arrayWithObject:indexPath];
    [tableView reloadRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationFade];    
}

#pragma make NSURLCONNECTION
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (shouyeimage_url==connection) {
        [listdata_shouye_image appendData:data];
    }
    if (shouyeclass_url==connection) {
       [listdata_shouye_class appendData:data];
    }
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
    
    shouyeimage_url = nil;
    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    ErrorBean *error=[[ErrorBean alloc] init];
    if (shouyeimage_url==connection) {
    
        NSString *image_returnString = [[NSString alloc] initWithData:listdata_shouye_image encoding:NSUTF8StringEncoding];
        [ShouYeImageXMLParse parseArrXML:image_returnString commentArr:imagedata errorBean:error];
        [self asyncimage];
        [image_returnString release];
    }
    if (shouyeclass_url==connection) {
        
        NSString *class_returnString = [[NSString alloc] initWithData:listdata_shouye_class encoding:NSUTF8StringEncoding];
        NSMutableArray *listdata=[[NSMutableArray alloc] init];
        [ShouYeClassXMLParse parseArrXML:class_returnString commentArr:listdata errorBean:error];
        self.classdata=listdata;
        [self.hometableview reloadData];
        [class_returnString release];
        [listdata release];
    }
    [self.progressInd stopAnimating];
    self.progressInd.hidden=YES;
    self.tabBarController.view.userInteractionEnabled = YES;
    self.navigationController.navigationBar.userInteractionEnabled = YES;
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

-(void)asyncimage  
{
    AsyncImageView *asyncimageview0= [[AsyncImageView alloc] initWithFrame:CGRectMake(0.0, 0.0,65.0, 65.0)];
    ShouYeImageBean *shouyeviewimage0=[imagedata objectAtIndex:0];
    [asyncimageview0 loadImageFromURL:[NSURL URLWithString:shouyeviewimage0.image_urlstring ] land:NO];
    
    AsyncImageView *asyncimageview1= [[AsyncImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 65.0, 65.0)];
    ShouYeImageBean *shouyeviewimage1=[imagedata objectAtIndex:1];
    [asyncimageview1 loadImageFromURL:[NSURL URLWithString:shouyeviewimage1.image_urlstring ] land:NO];
    
    AsyncImageView *asyncimageview2= [[AsyncImageView alloc] initWithFrame:CGRectMake(0.0,0.0,65.0, 65.0)];
    ShouYeImageBean *shouyeviewimage2=[imagedata objectAtIndex:2];
    [asyncimageview2 loadImageFromURL:[NSURL URLWithString:shouyeviewimage2.image_urlstring ] land:NO];
    
    [self.viewimage0 addSubview:asyncimageview0];
    [self.viewimage1 addSubview:asyncimageview1];
    [self.viewimage2 addSubview:asyncimageview2];
    
    [asyncimageview0 release];
    [asyncimageview1 release];
    [asyncimageview2 release];  
}

-(IBAction)button_chaoshi:(id)sender
{
    PaiGoStoreViewController *storecontroller=[[PaiGoStoreViewController alloc] initWithNibName:@"PaiGoStoreViewController" bundle:nil];
    storecontroller.page=1;
    storecontroller.count=10;
    [self.navigationController pushViewController:storecontroller animated:NO];
    [storecontroller release];
}

-(IBAction)button_viewimage0:(id)sender
{
    ShouYeImageBean *shouyeviewimage0=[imagedata objectAtIndex:0];
    NSInteger producy_id=shouyeviewimage0.image_id;
    PaiGoHomeImageController *imagecontroller = [[PaiGoHomeImageController alloc] initWithNibName:@"PaiGoHomeImageController" bundle:nil];
    imagecontroller.product_id=producy_id;
    [self.navigationController pushViewController:imagecontroller animated:NO];
     
    [imagecontroller release];
    //NSLog(@"producy_id=%d",producy_id);
    
}

-(IBAction)button_viewimage1:(id)sender
{
    ShouYeImageBean *shouyeviewimage0=[imagedata objectAtIndex:1];
    NSInteger producy_id=shouyeviewimage0.image_id;
    PaiGoHomeImageController *imagecontroller = [[PaiGoHomeImageController alloc] initWithNibName:@"PaiGoHomeImageController" bundle:nil];
    imagecontroller.product_id=producy_id;
    [self.navigationController pushViewController:imagecontroller animated:NO];
    
    [imagecontroller release];
}

-(IBAction)button_viewimage2:(id)sender
{
    ShouYeImageBean *shouyeviewimage0=[imagedata objectAtIndex:2];
    NSInteger producy_id=shouyeviewimage0.image_id;
    PaiGoHomeImageController *imagecontroller = [[PaiGoHomeImageController alloc] initWithNibName:@"PaiGoHomeImageController" bundle:nil];
    imagecontroller.product_id=producy_id;
    [self.navigationController pushViewController:imagecontroller animated:NO];
    
    [imagecontroller release];
}

#pragma make searchbar
-(IBAction)HomeViewclick:(id)sender
{
    [self.searchbar resignFirstResponder];
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    self.searchbar.showsCancelButton=YES;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    PaiGoSearchResultController *resultcontroller = [[PaiGoSearchResultController alloc] initWithNibName:@"PaiGoSearchResultController" bundle:nil];
    resultcontroller.searchtext=searchbar.text;
    [self.navigationController pushViewController:resultcontroller animated:YES];
    [resultcontroller release];
    [self.searchbar resignFirstResponder];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
     searchBar.text=@"";
    [self.searchbar resignFirstResponder];
}

@end
