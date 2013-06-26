//
//  PaiGoHomePageController.h
//  PaiGo
//
//  Created by apple  on 12-10-11.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface PaiGoHomePageController : UIViewController<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,NSURLConnectionDelegate,NSURLConnectionDataDelegate>
{

    NSMutableData *listdata_shouye_image;
    NSMutableData *listdata_shouye_class;
    NSURLConnection *shouyeimage_url;
    NSURLConnection *shouyeclass_url;
    NSMutableArray *imagedata;
    NSMutableArray *classdata;
    UIView *viewimage0;
    UIView *viewimage1;
    UIView *viewimage2;
    BOOL login_status;
    UITableView *hometableview;
    UISearchBar *searchbar;
    UIActivityIndicatorView *progressInd;
//    UIButton *button_viewimage0;
//    UIButton *button_viewimage1;
//    UIButton *button_viewimage2;
}

@property (retain,nonatomic) IBOutlet UIActivityIndicatorView *progressInd;
@property (assign,nonatomic) BOOL login_status;
@property (retain,nonatomic) IBOutlet UIView *viewimage0;
@property (retain,nonatomic) IBOutlet UIView *viewimage1;
@property (retain,nonatomic) IBOutlet UIView *viewimage2;
//@property (retain,nonatomic) IBOutlet UIButton *button_viewimage0;
//@property (retain,nonatomic) IBOutlet UIButton *button_viewimage1;
//@property (retain,nonatomic) IBOutlet UIButton *button_viewimage2;
@property (retain,nonatomic) NSMutableArray *imagedata;

@property (retain,nonatomic) IBOutlet UISearchBar *searchbar;
@property (retain,nonatomic) NSMutableArray *classdata;
@property (retain,nonatomic) IBOutlet UITableView *hometableview;



-(IBAction)TabBarLogin:(id)sender;
-(IBAction)HomeViewclick:(id)sender;
-(void)handleError:(NSError *)error;

-(IBAction)button_viewimage0:(id)sender;
-(IBAction)button_viewimage1:(id)sender;
-(IBAction)button_viewimage2:(id)sender;
-(IBAction)button_chaoshi:(id)sender;


@end
