//
//  PaiGoNearController.h
//  PaiGo
//
//  Created by apple  on 12-10-16.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@interface PaiGoNearController : UIViewController<UIActionSheetDelegate,UIPickerViewDelegate,UIPickerViewDataSource,NSURLConnectionDelegate,NSURLConnectionDataDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UIButton *OkButton,*CancelButton;
    UIActionSheet *actionSheet;
    UIPickerView *MyDistancePickerView,*MyClassPickerView,*MySortPickerView;
    NSInteger tag;
    NSArray *MyDistanceArray,*MyClassArray,*MySortArray;
    IBOutlet UIActivityIndicatorView *progressInd;
    NSMutableArray *near_array;
    NSMutableData *near_data;
    NSURLConnection *near_url;
    IBOutlet UITableView *near_tableview;
    NSString *distance;
    NSInteger  texttypes;
    BOOL b_near;
    NSString *message;
}
@property (retain,nonatomic) NSMutableArray *near_array;
@property (retain,nonatomic) IBOutlet UIButton *DistanceBtn,*ClassBtn,*SortBtn;
@property (retain,nonatomic) UIButton *OkButton,*CancelButton;
@property (retain,nonatomic) UIActionSheet *actionSheet;
@property (retain,nonatomic) UIPickerView *MyDistancePickerView,*MyClassPickerView,*MySortPickerView;
@property (retain,nonatomic) NSArray *MyDistanceArray,*MyClassArray,*MySortArray;
@property (retain,nonatomic) NSString *MyDistanceSheettext,*MyClassSheettext,*MySortSheettext;
@property (retain,nonatomic) NSString *DistanceBtntitle,*ClassBtntitle,*SortBtntitle;
@property (retain,nonatomic) NSString *returnStr;
-(IBAction)DistanceBtnclick:(id)sender;
-(IBAction)OkButtonclick:(id)sender;
-(IBAction)CancelButtonclick:(id)sender;
-(IBAction)ClassBtnclick:(id)sender;
-(IBAction)SortBtnclick:(id)sender;
@end
