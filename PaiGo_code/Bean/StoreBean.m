//
//  StoreBean.m
//  PaiGo
//
//  Created by perry on 12-11-16.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import "StoreBean.h"

@implementation StoreBean

@synthesize _id,merchant_pic,merchanttype_id,name,introText;



-(void)dealloc
{
    [merchant_pic release];
    [name release];
    [introText release];
    [super dealloc];
}
@end
