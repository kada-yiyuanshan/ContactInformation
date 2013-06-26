//
//  PaiGoHomeImageController.h
//  PaiGo
//
//  Created by perry on 12-11-14.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaiGoHomeImageController : UIViewController<NSURLConnectionDelegate,NSURLConnectionDataDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSInteger product_id;
    NSURLConnection *url_product_id;
    NSMutableData *data_product_id;
    NSMutableArray *array_product_id;
    UIActivityIndicatorView *progressInd;
    UITableView *imagetableview;
}

@property (retain,nonatomic) IBOutlet UITableView *imagetableview;
@property (retain,nonatomic) IBOutlet UIActivityIndicatorView *progressInd;
@property (assign,nonatomic) NSInteger product_id;
@property (retain,nonatomic) NSMutableArray *array_product_id;

@end
