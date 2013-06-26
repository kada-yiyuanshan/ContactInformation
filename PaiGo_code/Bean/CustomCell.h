//
//  CustomCell.h
//  PaiGo
//
//  Created by perry on 12-11-13.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell
{
    UILabel *name_product;
    UILabel *address_product;
    UILabel *titile_product;
    UILabel *count_product;
}
@property (retain,nonatomic) IBOutlet UILabel *name_product;
@property (retain,nonatomic) IBOutlet UILabel *address_product;
@property (retain,nonatomic) IBOutlet UILabel *titile_product;
@property (retain,nonatomic) IBOutlet UILabel *count_product;

@end
