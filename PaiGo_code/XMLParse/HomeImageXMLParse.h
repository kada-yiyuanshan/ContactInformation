//
//  HomeImageXMLParse.h
//  PaiGo
//
//  Created by perry on 12-11-14.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import <Foundation/Foundation.h>

#import <libxml/xmlreader.h>
#import <libxml/xmlmemory.h>

@class ErrorBean;
@class HomeImageBean;
@interface HomeImageXMLParse : NSObject

+(BOOL) parseArrXML:(NSString *)xml commentArr:(NSMutableArray*)_commentArr errorBean:(ErrorBean *)_error;

@end
