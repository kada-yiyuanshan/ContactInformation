//
//  PaiGoSearchResultController.m
//  PaiGo
//
//  Created by perry on 12-11-13.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import "PaiGoSearchResultController.h"
#import "ErrorBean.h"
#import "SearchBean.h"
#import "SearchResultXMLParse.h"
#import "CustomCell.h"

@interface PaiGoSearchResultController ()

@end

@implementation PaiGoSearchResultController

@synthesize searchtext;
@synthesize url_product;
@synthesize data_product;
@synthesize lidat_product;
@synthesize result_producttab;
@synthesize progressInd;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"商家优惠券";
    }
    return self;
}

-(void)dealloc
{
    [progressInd release];
    [result_producttab release];
    [lidat_product release];
    [data_product release];
    [url_product release];
    [searchtext release];
    [super dealloc];
}

- (void)viewDidLoad
{
    self.data_product=[[NSMutableData alloc] init];

    [self product_urlconnection];
    [super viewDidLoad];
}

-(void)product_urlconnection
{
    NSString *product_url = [NSString stringWithFormat:@"http://test.ksbtsoft.com/aocheng/trunk/restT/searchcouponsemerchants.xml?name=%@&page=1&count=10&order=",searchtext];
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:product_url]];
    self.url_product = [[[NSURLConnection alloc] initWithRequest:urlRequest delegate:self] autorelease];
    self.tabBarController.view.userInteractionEnabled = NO;
    self.navigationController.navigationBar.userInteractionEnabled = NO;
    [self.progressInd startAnimating];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma make TABLEVIEW

-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [lidat_product count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 85;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString  *TableSampleIdentifier=@"TableSampleIdentifier";
    CustomCell *cell=(CustomCell *)[tableView
                                    dequeueReusableCellWithIdentifier: TableSampleIdentifier];
    
    if(cell==nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomCell"
                                                     owner:self options:nil];
        for (id oneObject in nib)
            if ([oneObject isKindOfClass:[CustomCell class]])
                cell = (CustomCell *)oneObject;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSInteger row=[indexPath row];
    SearchBean *searchbean=[self.lidat_product objectAtIndex:row];
    cell.name_product.text=searchbean.name_product ;
    cell.address_product.text=searchbean.address_product;
    cell.count_product.text=[NSString stringWithFormat:@"已有%d人使用",searchbean.count_product];
    cell.titile_product.text=searchbean.title_product;
 
    return cell;
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath;
}

#pragma make NSURLCONNECTION
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
    [self.data_product appendData:data];
    
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
    
    self.url_product = nil;
    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    ErrorBean *error=[[ErrorBean alloc] init];
    
    NSString *product_returnString = [[NSString alloc] initWithData:self.data_product encoding:NSUTF8StringEncoding];
    NSMutableArray *listdata=[[NSMutableArray alloc] init];
    [SearchResultXMLParse parseArrXML:product_returnString commentArr:listdata errorBean:error];
    self.lidat_product=listdata;
    [self.result_producttab reloadData];
    [self.progressInd stopAnimating];
    self.progressInd.hidden=YES;
    self.tabBarController.view.userInteractionEnabled = YES;
    self.navigationController.navigationBar.userInteractionEnabled = YES;

    [product_returnString release];
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
