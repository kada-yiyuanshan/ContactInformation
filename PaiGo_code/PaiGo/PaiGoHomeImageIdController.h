//
//  PaiGoHomeImageIdController.h
//  PaiGo
//
//  Created by apple  on 12-11-17.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaiGoHomeImageIdController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSURLConnectionDelegate,NSURLConnectionDataDelegate,UIActionSheetDelegate>
{
    NSString *nav_title;
    IBOutlet UITableViewCell *cell0;
    IBOutlet UITableViewCell *cell1;
    IBOutlet UITableViewCell *cell2;
    IBOutlet UITableViewCell *cell3;
    IBOutlet UITableViewCell *cell4;
    IBOutlet UILabel *name;
    IBOutlet UILabel *phone;
    IBOutlet UILabel *tite;
    IBOutlet UILabel *date;
    IBOutlet UILabel *other;
    IBOutlet UIView *name_pic;
    IBOutlet UILabel *text3;
    IBOutlet UILabel *text4;
    IBOutlet UILabel *date1;
    IBOutlet UILabel *other1;
    IBOutlet UIImageView *fangxang_pic;
    IBOutlet UILabel *line;
    IBOutlet UIImageView *pngzheng_pic;
    IBOutlet UIButton *code;
    
    NSInteger coup_id;
    NSURLConnection *coup_url;
    NSMutableData *coup_data;
    NSMutableArray *coup_arry;
    UIActivityIndicatorView *progressInd;
    NSMutableArray *list_id;
    float height;
    NSArray *_listData;
}

@property(retain,nonatomic) NSString *nav_title;
@property(retain,nonatomic) NSMutableArray *list_id;
//@property(retain,nonatomic) UIButton *cellbutton;
@property(retain,nonatomic) NSMutableIndexSet *expandedSections;
@property(retain,nonatomic) IBOutlet UIActivityIndicatorView *progressInd;
@property(retain,nonatomic) NSURLConnection *coup_url;
@property(retain,nonatomic) NSMutableData *coup_data;
@property(retain,nonatomic) NSMutableArray *coup_arry;
@property(retain,nonatomic) IBOutlet UITableView *productinfotableview;
@property(assign,nonatomic) NSInteger coup_id;

-(IBAction)cellbuttonclick:(id)sender;
-(void)havemeassge:(NSString *)message;
-(void)callphone:(NSString *)phone;

@end
