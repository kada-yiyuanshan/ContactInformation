//
//  LoginPeopleBean.m
//  PaiGo
//
//  Created by perry on 12-11-12.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import "LoginPeopleBean.h"

@implementation LoginPeopleBean

@synthesize uesr_id,username,name,cell_phone;


-(void)dealloc
{

    [username release];
    [name release];
    [cell_phone release];
    [super dealloc];
}

@end
