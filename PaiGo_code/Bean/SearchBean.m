//
//  SearchBean.m
//  PaiGo
//
//  Created by perry on 12-11-13.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import "SearchBean.h"

@implementation SearchBean

@synthesize name_product;
@synthesize address_product;
@synthesize id_product;
@synthesize title_product;
@synthesize count_product;

-(void)dealloc
{
    [name_product release];
    [address_product release];
    [title_product release];
    [super dealloc];
}

@end
