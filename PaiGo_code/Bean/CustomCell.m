//
//  CustomCell.m
//  PaiGo
//
//  Created by perry on 12-11-13.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import "CustomCell.h"

@interface CustomCell ()

@end

@implementation CustomCell

@synthesize name_product,address_product,titile_product,count_product;

- (void)dealloc
{
    [name_product release];
    [address_product release];
    [titile_product release];
    [count_product release];
    [super dealloc];
}

@end
