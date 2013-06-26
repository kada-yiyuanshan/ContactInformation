//
//  DataBaseBean.h
//  ContactInformation
//
//  Created by apple  on 12-10-31.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataBaseBean : NSObject
{
    NSInteger _id;
    NSString *firstname;
    NSString *lastname;
    NSString *gender;
    NSInteger phone;
    NSString *email;
    NSString *address;
    
 
}

@property(nonatomic,assign) NSInteger _id;
@property(retain,nonatomic) NSString *firstname;
@property(retain,nonatomic) NSString *lastname;
@property(retain,nonatomic) NSString *gender;
@property(nonatomic,assign) NSInteger phone;
@property(nonatomic,retain) NSString *email;
@property(nonatomic,retain) NSString *address;

-(id)InitPeopleContact:(NSInteger )_idbean FirstName:(NSString *)firstnamebean LastName:(NSString *)lastnamebean Gender:(NSString *)genderbean Phone:(NSInteger )phonebean Email:(NSString *)emailbean Address:(NSString *)addressbean;


@end
