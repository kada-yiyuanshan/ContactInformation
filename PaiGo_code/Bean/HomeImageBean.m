//
//  HomeImageBean.m
//  PaiGo
//
//  Created by perry on 12-11-14.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import "HomeImageBean.h"

@implementation HomeImageBean

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
