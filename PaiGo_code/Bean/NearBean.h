//
//  NearBean.h
//  PaiGo
//
//  Created by perry on 12-11-19.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NearBean : NSObject
{
    NSString *near_name;
    NSString *near_address;
    float near_distance;
    NSInteger near_count;
    NSInteger near_id;
    NSString *near_title;
}

@property (retain,nonatomic) NSString *near_name;
@property (retain,nonatomic) NSString *near_address;
@property (retain,nonatomic) NSString *near_title;
@property (assign,nonatomic) float near_distance;
@property (assign,nonatomic) NSInteger near_count;
@property (assign,nonatomic) NSInteger near_id;

@end
