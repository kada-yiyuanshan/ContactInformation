//
//  CouponDataBaseBean.m
//  PaiGo
//
//  Created by perry on 12-11-15.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import "CouponDataBaseBean.h"

@implementation CouponDataBaseBean

@synthesize name_coupon,title_coupon,address_coupon,id_coupon,tableid;

-(id)init_id:(NSInteger )table_id name_coupon:(NSString *)name coupon_id:(NSInteger )_id title_coupon:(NSString *)title address_coupon:(NSString *)address
{
    self=[super init];
    
    if (self) {
        self.tableid=table_id;
        self.name_coupon=name;
        self.title_coupon=title;
        self.address_coupon=address;
        self.id_coupon=_id;
    }
    return self;
}
-(void)dealloc
{

    [name_coupon release];
    [title_coupon release];
    [address_coupon release];
    [super dealloc];
}

@end
