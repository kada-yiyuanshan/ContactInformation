//
//  NearXMLParse.h
//  PaiGo
//
//  Created by perry on 12-11-19.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <libxml/xmlreader.h>
#import <libxml/xmlmemory.h>

@class ErrorBean;
@class NearBean;

@interface NearXMLParse : NSObject

+(BOOL) parseArrXML:(NSString *)xml commentArr:(NSMutableArray*)_commentArr errorBean:(ErrorBean *)_error;
@end
