//
//  CouponDataBaseBean.h
//  PaiGo
//
//  Created by perry on 12-11-15.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CouponDataBaseBean : NSObject
{
    NSString *name_coupon;
    NSString *title_coupon;
    NSString *address_coupon;
    NSInteger id_coupon;
    NSInteger tableid;
}

@property(retain,nonatomic) NSString *name_coupon;
@property(retain,nonatomic) NSString *title_coupon;
@property(retain,nonatomic) NSString *address_coupon;
@property(assign,nonatomic) NSInteger id_coupon;
@property(assign,nonatomic) NSInteger tableid;

-(id)init_id:(NSInteger )table_id name_coupon:(NSString *)name coupon_id:(NSInteger )_id  title_coupon:(NSString *)title address_coupon:(NSString *)address ;

@end
