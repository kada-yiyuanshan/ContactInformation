//
//  ShouYeImageBean.h
//  PaiGo
//
//  Created by perry on 12-11-12.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShouYeImageBean : NSObject
{
    int image_id;
    NSString *image_urlstring;
}

@property(assign,nonatomic) int image_id;
@property(retain,nonatomic) NSString *image_urlstring;

@end
