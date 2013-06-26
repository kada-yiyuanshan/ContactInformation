//
//  ShouYeClassBean.m
//  PaiGo
//
//  Created by perry on 12-11-13.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import "ShouYeClassBean.h"

@implementation ShouYeClassBean

@synthesize _id;
@synthesize name;

-(void)dealloc
{
    [name release];
    [super dealloc];
}
@end
