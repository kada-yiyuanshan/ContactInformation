//
//  PaiGoStoreViewController.m
//  PaiGo
//
//  Created by perry on 12-11-16.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import "PaiGoStoreViewController.h"
#import "ErrorBean.h"
#import "StoreBean.h"
#import "StoreXMLParse.h"

@interface PaiGoStoreViewController ()

@end

@implementation PaiGoStoreViewController

@synthesize store_arry;
@synthesize store_tableview;
@synthesize page;
@synthesize count;
@synthesize expandedSections;
-(void)dealloc   
{
    [progressInd release];
    [expandedSections release];
    [store_arry release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"商家";
    }
    return self;
}

- (void)viewDidLoad
{
    store_arry =[[NSMutableArray alloc] init];
    if (!expandedSections)
    {
        expandedSections = [[NSMutableIndexSet alloc] init];
    }

    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self store_urlconnection:self.page countnumb:self.count];
}
- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
}

-(void)store_urlconnection:(NSInteger )pages countnumb:(NSInteger )countnu
{
    if (store_url!=nil) {
        [store_url release];
    }
    if (store_data!=nil) {
        [store_data release];
    }
    NSString *product_url = [NSString stringWithFormat:@"http://test.ksbtsoft.com/aocheng/trunk/restT/listmerchantsbytype.xml?page=%d&count=%d&order=asc",pages,countnu];
    NSURLRequest *image_urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:product_url]];
    store_url= [[NSURLConnection alloc] initWithRequest:image_urlRequest delegate:self];
    store_data=[[NSMutableData alloc] init];
    [self.progressInd startAnimating];
    h_page=countnu+10;
}

#pragma make TABLEVIEW

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int counts=[self.store_arry count];
    if (counts!=errorcounts) {
        return  counts+1;
    }
    if (counts==errorcounts) {
        return counts;
    }
    return counts;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row==[self.store_arry count]) {
        return 35;
    }
    return 45;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString  *TableSampleIdentifier=@"TableSampleIdentifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
  
    if ([indexPath row]==[self.store_arry count]) {
        if(cell==nil)
        {
            cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TableSampleIdentifier] autorelease];
        }
        if ([self.store_arry count]!=errorcounts) {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.text=@"                   加载更多";
            cell.textLabel.textColor=[UIColor grayColor];
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            
        } if ([self.store_arry count]==errorcounts){
        
        }
        return cell;
    }
    if(cell==nil)
    {
        cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                     reuseIdentifier:TableSampleIdentifier] autorelease];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSInteger row=[indexPath row];
    StoreBean *storebean=[self.store_arry objectAtIndex:row];
    cell.textLabel.text=storebean.name;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor=[UIColor  blackColor];
    cell.detailTextLabel.text=storebean.introText;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:11];
    cell.detailTextLabel.textColor=[UIColor redColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.store_tableview cellForRowAtIndexPath:indexPath];
    if (indexPath.row == [self.store_arry count]) {
        [self.progressInd startAnimating];
        [expandedSections addIndex:[indexPath section]];
        cell.textLabel.text=@"                   正在加载...";
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        [self store_urlconnection:1 countnumb:h_page];
     }
}

#pragma make NSURLCONNECTION
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    return [store_data appendData:data];
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
    
    store_url = nil;
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    ErrorBean *error=[[ErrorBean alloc] init];
    NSString *store_returnString = [[NSString alloc] initWithData:store_data encoding:NSUTF8StringEncoding];
    NSMutableArray *listdata=[[NSMutableArray alloc] init];
    [ StoreXMLParse parseArrXML:store_returnString commentArr:listdata errorBean:error];
    self.store_arry =listdata;
    [self.store_tableview reloadData];
    errorcounts=error.counts;
    [self.progressInd stopAnimating];
    self.progressInd.hidden=YES;
    [store_returnString release];
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




@end
