//
//  ContentBean.h
//  ContactInformation
//
//  Created by apple  on 12-10-30.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContentBean : NSObject
{
    NSString *firstname;
    NSString *lastname;
    NSString *gender;
    NSInteger phone;
    NSString *email;
    NSString *address;
}

@property(retain,nonatomic) NSString *firstname;
@property(retain,nonatomic) NSString *lastname;
@property(retain,nonatomic) NSString *gender;
@property(nonatomic,assign) NSInteger phone;
@property(nonatomic,retain) NSString *email;
@property(nonatomic,retain) NSString *address;

@end
