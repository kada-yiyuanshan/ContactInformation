//
//  ShouYeClassXMLParse.h
//  PaiGo
//
//  Created by perry on 12-11-13.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <libxml/xmlreader.h>
#import <libxml/xmlmemory.h>

@class ErrorBean;
@class ShouYeClassBean;
@interface ShouYeClassXMLParse : NSObject

+(BOOL) parseArrXML:(NSString *)xml commentArr:(NSMutableArray*)_commentArr errorBean:(ErrorBean *)_error;
@end
