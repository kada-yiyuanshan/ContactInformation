//
//  ContactInformationViewController.h
//  ContactInformation
//
//  Created by apple  on 12-10-30.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HelpDataBase.h"
#import "DataBaseBean.h"
#import "AddViewController.h"



@interface ContactInformationViewController : UITableViewController<UISearchBarDelegate,UISearchDisplayDelegate,UISearchDisplayDelegate>
{
    NSMutableArray *listdata;
    HelpDataBase *helpdatabase;
    DataBaseBean *databasebean;
    NSMutableArray *indexlist;
    UISearchBar *mysearchBar;
    NSMutableArray *filteredListContent;
    NSDictionary *names;
    NSArray *keys;
    //index
    NSMutableArray *data;
    
}

@property (retain,nonatomic) NSDictionary *names;
@property(retain,nonatomic) NSMutableArray *data;
@property(retain,nonatomic) IBOutlet UISearchBar *mysearchBar;
@property(retain,nonatomic) NSMutableArray *listdata;
@property(retain,nonatomic) NSMutableArray *indexlist;
@property (nonatomic, retain) NSMutableArray *filteredListContent;
@property (nonatomic, retain) NSArray *keys;

-(IBAction)addclick:(id)sender;
-(void)filterContentForSearchText:(NSString*)searchText;

@end
