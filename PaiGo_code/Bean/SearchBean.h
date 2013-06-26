//
//  SearchBean.h
//  PaiGo
//
//  Created by perry on 12-11-13.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchBean : NSObject
{
    NSString *name_product;
    NSString *address_product;
    NSInteger id_product;
    NSString *title_product;
    NSInteger count_product;
}

@property(retain,nonatomic) NSString *name_product;
@property(retain,nonatomic) NSString *address_product;
@property(assign,nonatomic) NSInteger id_product;
@property(retain,nonatomic) NSString *title_product;
@property(assign,nonatomic) NSInteger count_product;

@end
