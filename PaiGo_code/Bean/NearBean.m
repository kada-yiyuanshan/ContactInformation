//
//  NearBean.m
//  PaiGo
//
//  Created by perry on 12-11-19.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import "NearBean.h"

@implementation NearBean

@synthesize near_name,near_address,near_distance,near_count,near_id,near_title;

-(void)dealloc
{
    [near_name release];
    [near_title release];
    [near_address release];
    [super dealloc];
}

@end
