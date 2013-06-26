//
//  PaiGoHomeImageController.m
//  PaiGo
//
//  Created by perry on 12-11-14.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import "PaiGoHomeImageController.h"
#import "HomeImageBean.h"
#import "HomeImageXMLParse.h"
#import "ErrorBean.h"
#import "PaiGoHomeImageIdController.h"
#import "CustomCell.h"

@interface PaiGoHomeImageController ()

@end

@implementation PaiGoHomeImageController

@synthesize product_id;
@synthesize array_product_id;
@synthesize progressInd;
@synthesize imagetableview;

-(void)dealloc
{
    [imagetableview release];
    [progressInd release];
    [array_product_id release];
 
    
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"商家优惠券";
    }
    return self;
}

- (void)viewDidLoad
{
    array_product_id =[[NSMutableArray alloc] init];
   
  
    [super viewDidLoad];
  
}

-(void)viewWillAppear:(BOOL)animated
{
    
    self.tabBarController.view.userInteractionEnabled = NO;
    self.navigationController.navigationBar.userInteractionEnabled = NO;
    
    [self product_urlconnection];
}

-(void)product_urlconnection
{
    if (url_product_id!=nil) {
        [url_product_id release];
    }
    if (data_product_id!=nil) {
        [data_product_id release];
    }
        NSString *product_url = [NSString stringWithFormat:@"http://test.ksbtsoft.com/aocheng/trunk/restT/listcouponsbymid.xml?mid=%d&page=1&count=10&order=",product_id];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:product_url]];
        url_product_id = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
        data_product_id =[[NSMutableData alloc] init];
        [self.progressInd startAnimating];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma make TABLEVIEW

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.array_product_id count];
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
    HomeImageBean *imagebean=[self.array_product_id objectAtIndex:row];
    cell.name_product.text=imagebean.name_product;
    cell.address_product.text=imagebean.address_product;
    cell.count_product.text=[NSString stringWithFormat:@"已有%d人使用",imagebean.count_product];
    cell.titile_product.text=imagebean.title_product;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PaiGoHomeImageIdController *imageidcontroller =[[[PaiGoHomeImageIdController alloc] initWithNibName:@"PaiGoHomeImageIdController" bundle:nil] autorelease];
     NSInteger row=[indexPath row];
     HomeImageBean *imagebean=[self.array_product_id objectAtIndex:row];
    imageidcontroller.nav_title=imagebean.name_product;
    imageidcontroller.coup_id=imagebean.id_product;
    [self.navigationController pushViewController:imageidcontroller animated:YES];
}


#pragma make NSURLCONNECTION
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    return [data_product_id appendData:data];
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
    
    url_product_id = nil;

}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    ErrorBean *error=[[ErrorBean alloc] init];
    NSString *home_image_returnString = [[NSString alloc] initWithData:data_product_id encoding:NSUTF8StringEncoding];
    NSMutableArray *listdata=[[NSMutableArray alloc] init];
    [ HomeImageXMLParse parseArrXML:home_image_returnString commentArr:listdata errorBean:error];
    self.array_product_id=listdata;
    [self.imagetableview reloadData];
    [self.progressInd stopAnimating];
    self.progressInd.hidden=YES;
    [home_image_returnString release];
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
