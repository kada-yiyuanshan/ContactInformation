//
//  PaiGoMoreYouHuiController.h
//  PaiGo
//
//  Created by perry on 12-11-19.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaiGoMoreYouHuiController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *youhui_tableview;
    NSMutableArray *youhui_array;
    BOOL d_edit;
}

@property (retain,nonatomic) IBOutlet UITableView *youhui_tableview;
@property (retain,nonatomic) NSMutableArray *youhui_array;

-(IBAction)doneclick:(id)sender;
-(IBAction)editclick:(id)sender;
@end
