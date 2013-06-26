//
//  ContentBean.m
//  ContactInformation
//
//  Created by apple  on 12-10-30.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import "ContentBean.h"

@implementation ContentBean

@synthesize firstname,lastname,gender,email,address;
@synthesize phone;

-(void)dealloc
{
    [firstname release];
    [lastname release];
    [gender release];
    [email release];
    [address release];
    
    [super dealloc];
}

@end
