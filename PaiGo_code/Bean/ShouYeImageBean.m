//
//  ShouYeImageBean.m
//  PaiGo
//
//  Created by perry on 12-11-12.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import "ShouYeImageBean.h"

@implementation ShouYeImageBean

@synthesize image_id;
@synthesize image_urlstring;

-(void)dealloc
{
    [image_urlstring release];
    [super dealloc];
}
@end
