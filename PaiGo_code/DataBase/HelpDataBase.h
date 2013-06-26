//
//  HelpDataBase.h
//  ContactInformation
//
//  Created by apple  on 12-10-31.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "CouponDataBaseBean.h"

@interface HelpDataBase : NSObject
{
    sqlite3 *database;
}

-(void)opendatabase;
-(void)insertTotable:(CouponDataBaseBean *)info;
//-(void)updateTotable:(CouponDataBaseBean *)info;
-(void)deleteTotable:(CouponDataBaseBean *)info;
-(void)queryTotable:(NSMutableArray *)_arr ;
-(void)queryTotable_id:(NSMutableArray *)_arr ;

@end
