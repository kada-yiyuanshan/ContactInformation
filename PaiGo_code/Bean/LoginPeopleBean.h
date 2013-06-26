//
//  LoginPeopleBean.h
//  PaiGo
//
//  Created by perry on 12-11-12.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginPeopleBean : NSObject
{
    int uesr_id;
    NSString *username;
    NSString *name;
    NSString *cell_phone;
}

@property(assign,nonatomic) int uesr_id;
@property(retain,nonatomic) NSString *username;
@property(retain,nonatomic) NSString *name;
@property(retain,nonatomic) NSString *cell_phone;
@end
