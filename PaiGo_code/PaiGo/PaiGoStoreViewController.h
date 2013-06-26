//
//  PaiGoStoreViewController.h
//  PaiGo
//
//  Created by perry on 12-11-16.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaiGoStoreViewController : UIViewController<NSURLConnectionDelegate,NSURLConnectionDataDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSMutableData *store_data;
    NSMutableArray *store_arry;
    NSURLConnection *store_url;
    UITableView *store_tableview;
    NSInteger page;
    NSInteger count;
    NSInteger errorcounts;
    NSInteger errorpage;
    NSInteger h_page;
    UIActivityIndicatorView *progressInd;
}

@property (retain,nonatomic) IBOutlet UIActivityIndicatorView *progressInd;
@property(assign,nonatomic) NSInteger page;
@property(assign,nonatomic) NSInteger count;
@property(retain,nonatomic) NSMutableIndexSet *expandedSections;
@property(retain,nonatomic) NSMutableArray *store_arry;
@property(retain,nonatomic) IBOutlet UITableView *store_tableview;

@end
