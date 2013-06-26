//
//  HelpDataBase.h
//  ContactInformation
//
//  Created by apple  on 12-10-31.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "DataBaseBean.h"

@interface HelpDataBase : NSObject
{
    sqlite3 *database;
}

-(void)opendatabase;
-(void)insertTotable:(DataBaseBean *)info;
-(void)updateTotable:(DataBaseBean *)info;
-(void)deleteTotable:(DataBaseBean *)info;
-(void)queryTotable:(NSMutableArray *)_arr;

@end
