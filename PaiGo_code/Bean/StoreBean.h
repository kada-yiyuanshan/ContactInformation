//
//  StoreBean.h
//  PaiGo
//
//  Created by perry on 12-11-16.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreBean : NSObject
{
    NSInteger _id;
    NSInteger merchanttype_id;
    NSString *introText;
    NSString *name;
    NSString *merchant_pic;
}

@property(assign,nonatomic) NSInteger _id;
@property(assign,nonatomic) NSInteger merchanttype_id;
@property(retain,nonatomic) NSString *introText;
@property(retain,nonatomic) NSString *name;
@property(retain,nonatomic) NSString *merchant_pic;
@end
