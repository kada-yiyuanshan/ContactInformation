//
//  HomeImageIdBean.m
//  PaiGo
//
//  Created by perry on 12-11-14.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import "HomeImageIdBean.h"

@implementation HomeImageIdBean

@synthesize name,address;
@synthesize merchant_pic,name_pic;
@synthesize title;
@synthesize start_time,end_time;
@synthesize _id,phone,count;
@synthesize other;

-(void)dealloc
{
    [other release];
    [name_pic release];
    [name release];
    [address release];
    [merchant_pic release];
    [start_time release];
    [end_time release];
    [title release];
    [super dealloc];
}

@end
