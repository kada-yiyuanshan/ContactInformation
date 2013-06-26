//
//  PaiGoSearchResultController.h
//  PaiGo
//
//  Created by perry on 12-11-13.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaiGoSearchResultController : UIViewController<NSURLConnectionDelegate,NSURLConnectionDataDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSString *searchtext;
    NSURLConnection *url_product;
    NSMutableData *data_product;
    NSMutableArray *lidat_product;
    UITableView  *result_producttab;
    UIActivityIndicatorView *progressInd;
}

@property (retain,nonatomic) IBOutlet UIActivityIndicatorView *progressInd;
@property(retain,nonatomic) NSURLConnection *url_product;
@property(retain,nonatomic) NSString *searchtext;
@property(retain,nonatomic) NSMutableData *data_product;
@property(retain,nonatomic) NSMutableArray *lidat_product;
@property(retain,nonatomic) IBOutlet UITableView  *result_producttab;

@end
