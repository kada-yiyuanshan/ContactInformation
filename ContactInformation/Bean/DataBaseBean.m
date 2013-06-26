//
//  DataBaseBean.m
//  ContactInformation
//
//  Created by apple  on 12-10-31.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import "DataBaseBean.h"

@implementation DataBaseBean

@synthesize firstname,lastname,gender,email,address;
@synthesize phone,_id;

-(id)InitPeopleContact:(NSInteger)_idbean FirstName:(NSString *)firstnamebean LastName:(NSString *)lastnamebean Gender:(NSString *)genderbean Phone:(NSInteger)phonebean Email:(NSString *)emailbean Address:(NSString *)addressbean
{
    self=[super init];
    
    if (self) {
        self._id=_idbean;
        self.firstname=firstnamebean;
        self.lastname=lastnamebean;
        self.gender=genderbean;
        self.phone=phonebean;
        self.email=emailbean;
        self.address=addressbean;
    }
  
    return self;
}


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
