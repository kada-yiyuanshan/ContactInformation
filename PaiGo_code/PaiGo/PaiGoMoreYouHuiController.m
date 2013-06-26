//
//  PaiGoMoreYouHuiController.m
//  PaiGo
//
//  Created by perry on 12-11-19.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import "PaiGoMoreYouHuiController.h"
#import "CustomCell.h"
#import "HelpDataBase.h"
#import "CouponDataBaseBean.h"
#import "PaiGoHomeImageIdController.h"

@interface PaiGoMoreYouHuiController ()

@end

@implementation PaiGoMoreYouHuiController

@synthesize youhui_array;
@synthesize youhui_tableview;

-(void)dealloc
{
    [youhui_array release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       self.title=@"我的优惠券";
    }
    return self;
}

- (void)viewDidLoad
{
    youhui_array =[[NSMutableArray alloc] init];
    
    UIBarButtonItem *rightbutton1=[[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonSystemItemDone target:self action:@selector(editclick:)];
        self.navigationItem.rightBarButtonItem=rightbutton1;
    HelpDataBase *help=[[HelpDataBase alloc] init];
    [help queryTotable:self.youhui_array];
    [help release];
    [rightbutton1 release];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(IBAction)editclick:(id)sender
{
    [self.youhui_tableview setEditing:YES animated:YES];
    d_edit=NO;
    if (d_edit==NO) {
      UIBarButtonItem *rightbutton2=[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonSystemItemEdit target:self action:@selector(doneclick:)];
      self.navigationItem.rightBarButtonItem=rightbutton2;
        [rightbutton2 release];
    }
    
}
-(IBAction)doneclick:(id)sender
{
    [self.youhui_tableview setEditing:NO animated:YES];
    d_edit=YES;
    if (d_edit) {
        UIBarButtonItem *rightbutton1=[[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonSystemItemDone target:self action:@selector(editclick:)];
        self.navigationItem.rightBarButtonItem=rightbutton1;
        [rightbutton1 release];
    }
}
#pragma make TABLEVIEW

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.youhui_array count];
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
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSInteger row=[indexPath row];
    CouponDataBaseBean *coupondata=[self.youhui_array objectAtIndex:row];
    cell.name_product.text=coupondata.name_coupon;
    cell.titile_product.text=coupondata.title_coupon;
    cell.address_product.text=coupondata.address_coupon;
  return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PaiGoHomeImageIdController *imageidcontroller =[[[PaiGoHomeImageIdController alloc] initWithNibName:@"PaiGoHomeImageIdController" bundle:nil] autorelease];
    NSInteger row=[indexPath row];
    CouponDataBaseBean *coupondata=[self.youhui_array objectAtIndex:row];
    imageidcontroller.nav_title=coupondata.name_coupon;
    imageidcontroller.coup_id=coupondata.id_coupon;
    [self.navigationController pushViewController:imageidcontroller animated:YES];

}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[self.youhui_tableview setEditing:self.youhui_tableview.editing animated:YES];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        HelpDataBase *help=[[HelpDataBase alloc] init];
        CouponDataBaseBean *coupondata=[[CouponDataBaseBean alloc] init];
        coupondata= [self.youhui_array objectAtIndex:indexPath.row];
        //delete data from sqlite
        [help deleteTotable:coupondata];
        //delete data from array
        [self.youhui_array removeObjectAtIndex:indexPath.row];
        //delete data from tableview
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
        [help release];
        [coupondata release];
    }
}


@end
