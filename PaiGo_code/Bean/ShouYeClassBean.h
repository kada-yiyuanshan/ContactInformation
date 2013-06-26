//
//  ShouYeClassBean.h
//  PaiGo
//
//  Created by perry on 12-11-13.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShouYeClassBean : NSObject
{
    NSString  *name;
    int _id;
}

@property (retain,nonatomic) NSString  *name;
@property (assign,nonatomic) int _id;
@end
