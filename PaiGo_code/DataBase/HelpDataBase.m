//
//  HelpDataBase.m
//  ContactInformation
//
//  Created by apple  on 12-10-31.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import "HelpDataBase.h"
#import "CouponDataBaseBean.h"

#define DB_NAME @"youhuiquan.sqlite"

@implementation HelpDataBase

- (id)init
{
    self = [super init];
    if (self) {
        [self opendatabase];
    }
    
    return self;
}
- (NSString *)dataFilePath
{
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
  
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:DB_NAME];
    success = [fileManager fileExistsAtPath:writableDBPath];
    if (!success) {
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:DB_NAME];
        success = [fileManager copyItemAtPath:defaultDBPath toPath:
                   writableDBPath error:&error];
        if (!success) {
           
        }
    }
    return writableDBPath;
}
-(void)opendatabase
{
   
        int open=sqlite3_open([self.dataFilePath UTF8String], &database);
        //NSLog(@"open=%d",open);
        if ( open!= SQLITE_OK) {
             sqlite3_close(database);
            NSLog(@"open database error! ");
        }
    }



-(void)insertTotable:(CouponDataBaseBean *)info
{  
   
    char *error;
  
    NSString *insertsql=[NSString stringWithFormat:@"insert into Coupon (name,title,address,coupon_id) VALUES ('%@','%@','%@','%d')",info.name_coupon,info.title_coupon,info.address_coupon,info.id_coupon];
    int insert=sqlite3_exec(database, [insertsql UTF8String], NULL, NULL, &error);
       // NSLog(@"insert=%d",insert);
       // NSLog(@"error=%s",error);
        if (insert!=SQLITE_OK) {
           NSLog(@"insert data error !");
        sqlite3_close(database);
            
        }
        else
        {
            //NSLog(@"insert data OK !");
        }
    
}

//- (void)updateTotable:(CouponDataBaseBean *)info
//{
//    char *error;
//	NSString *sql = [NSString stringWithFormat:@"update Coupon set firstname= '%@',lastname= '%@',gender= '%@',phone= '%d',Email= '%@',address= '%@'  where id = %d",info.firstname,info.lastname,info.gender,info.phone,info.email,info.address,info._id];
//    int updata=sqlite3_exec(database, [sql UTF8String], NULL, NULL, &error) ;
//	if (updata!= SQLITE_OK) {
//        NSLog(@"update error");
//		sqlite3_close(database);
//	}
//	
//}

-(void)deleteTotable:(CouponDataBaseBean *)info
{
    char *szError = 0;
    NSString *sql = [[NSString alloc] initWithFormat:@"delete from Coupon where id = %d;", info.tableid];
   // NSLog(@"info.UserId=%d",info._id);
    int result = sqlite3_exec(database, [sql UTF8String], 0, 0, &szError);
    if (result != SQLITE_OK) {
        NSLog(@"delete data error!");
        sqlite3_close(database);
    }
    else{
        //NSLog(@"delete data OK!");
    }
   // [sql release];
    
}

-(void)queryTotable:(NSMutableArray *)_arr 
{

    sqlite3_stmt *statement=nil;
    NSString *sql = @"select * from Coupon;";
    int get=sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil);
   // NSLog(@"get=%d",get);
    if (get==SQLITE_OK){
        while (sqlite3_step(statement)==SQLITE_ROW)
		{
            NSInteger _id=sqlite3_column_int(statement, 0);
			NSString *name=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 1) encoding:NSUTF8StringEncoding];
            NSString *title=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 2) encoding:NSUTF8StringEncoding];
            NSString *address=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 3) encoding:NSUTF8StringEncoding];
            NSInteger coupon_id=sqlite3_column_int(statement, 4);
            
           
            CouponDataBaseBean *databasebean=[[CouponDataBaseBean alloc] init_id:_id name_coupon:name coupon_id:coupon_id title_coupon:title address_coupon:address];
            [_arr addObject:databasebean];
            
            [name release];
            [title release];
            [address release];
		}
		sqlite3_finalize(statement);
        statement = nil;
       
    } else
    {
        sqlite3_close(database);
    }
    [sql release];
}

-(void)queryTotable_id:(NSMutableArray *)_arr
{
    sqlite3_stmt *statement=nil;
    NSString *sql = @"select * from Coupon;";
    int get=sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil);
   
    if (get==SQLITE_OK){
        while (sqlite3_step(statement)==SQLITE_ROW)
		{
            NSInteger coupon_id=sqlite3_column_int(statement, 4);
            CouponDataBaseBean *databasebean=[[CouponDataBaseBean alloc] init];
            databasebean.id_coupon=coupon_id;
    
            [_arr addObject:databasebean];
		}
		sqlite3_finalize(statement);
        statement = nil;
        
    } else
    {
        sqlite3_close(database);
    }
    [sql release];

}

@end
