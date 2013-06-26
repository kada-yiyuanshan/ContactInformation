//
//  HomeImageIdBean.h
//  PaiGo
//
//  Created by perry on 12-11-14.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeImageIdBean : NSObject
{
    int _id;
    NSString *name;
    NSString *address;
    NSInteger phone;
    NSString *merchant_pic;
    NSString *title;
    NSString *start_time;
    NSString *end_time;
    NSInteger count;
    NSString *name_pic;
    NSString *other;
}

@property(assign,nonatomic) int _id;
@property(retain,nonatomic) NSString *name;
@property(retain,nonatomic) NSString *address;
@property(retain,nonatomic) NSString *merchant_pic;
@property(retain,nonatomic) NSString *name_pic;
@property(retain,nonatomic) NSString *title;
@property(retain,nonatomic) NSString *start_time;
@property(retain,nonatomic) NSString *end_time;
@property(assign,nonatomic) NSInteger phone;
@property(assign,nonatomic) NSInteger count;
@property(retain,nonatomic) NSString *other;


@end
