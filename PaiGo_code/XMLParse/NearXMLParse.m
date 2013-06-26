//
//  NearXMLParse.m
//  PaiGo
//
//  Created by perry on 12-11-19.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import "NearXMLParse.h"
#import "NearBean.h"
#import "ErrorBean.h"

@implementation NearXMLParse


+(BOOL) parseArrXML:(NSString *)xml commentArr:(NSMutableArray*)_commentArr errorBean:(ErrorBean *)_error;
{
	
    //NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	xmlDocPtr doc = xmlParseMemory([xml UTF8String], [xml lengthOfBytesUsingEncoding:NSUTF8StringEncoding]);
	if(doc ==nil)
	{
		[NSException raise:NSGenericException format:@"class xml error"];
	}
	xmlNodePtr root = xmlDocGetRootElement(doc);
	
	xmlNodePtr node = root->children;
	
	xmlNodePtr cur_node;
	
    
	
	for(cur_node = node;cur_node;cur_node = cur_node->next)
	{
		
		NSString *cur_name = [NSString stringWithUTF8String:(char *)cur_node->name];
		if([cur_name isEqual:@"status"])
		{
			NSString *content = [NSString stringWithUTF8String:(char *)cur_node->children->content];
			_error.status= content;
		}else if([cur_name isEqual:@"message"])
		{
			if (cur_node->children != nil)  {
				NSString *content = [NSString stringWithUTF8String:(char *)cur_node->children->content];
				_error.errorMessage= content;
			}else {
				_error.errorMessage = @"";
			}
		}else if([cur_name isEqual:@"merchant"])
		{
			
			xmlNodePtr c2_node =cur_node->children;
			xmlNodePtr cur2_node;
			NearBean *comment = [[NearBean alloc] init];
			for(cur2_node = c2_node;cur2_node;cur2_node=cur2_node->next)
			{
                
				NSString *cur2_name = [NSString stringWithUTF8String:(char *)cur2_node->name];
				if([@"merchants" isEqual:cur2_name])
                {
                    xmlNodePtr c3_node =cur2_node->children;
                    xmlNodePtr cur3_node;
                    for(cur3_node = c3_node;cur3_node;cur3_node=cur3_node->next)
                    {
                        NSString *cur3_name = [NSString stringWithUTF8String:(char *)cur3_node->name];
                        if ([@"name" isEqual:cur3_name]) {
                            if (cur3_node->children != nil)  {
                                NSString * content = [NSString stringWithUTF8String:(char *)cur3_node->children->content];
                                comment.near_name =content;
                                
                            }else {
                                comment.near_name=@"";
                            }
                        }else if ([@"address" isEqual:cur3_name]) {
                            if (cur3_node->children != nil)  {
                                NSString * content = [NSString stringWithUTF8String:(char *)cur3_node->children->content];
                                comment.near_address =content;
                                
                            }else {
                                comment.near_address=@"";
                            }
                        }else if ([@"distance" isEqual:cur3_name]) {
                            if (cur3_node->children != nil)  {
                                NSString * content = [NSString stringWithUTF8String:(char *)cur3_node->children->content];
                                comment.near_distance =[content floatValue];
                                
                            }else {
                                comment.near_distance=0.0;
                            }
                        }
                        
                    }
                }else if([@"couponses" isEqual:cur2_name])
                {
                    xmlNodePtr c3_node =cur2_node->children;
                    xmlNodePtr cur3_node;
                    for(cur3_node = c3_node;cur3_node;cur3_node=cur3_node->next)
                    {
                        NSString *cur3_name = [NSString stringWithUTF8String:(char *)cur3_node->name];
                        if ([@"id" isEqual:cur3_name]) {
                            if (cur3_node->children != nil)  {
                                NSString * content = [NSString stringWithUTF8String:(char *)cur3_node->children->content];
                                comment.near_id =[content integerValue];
                                
                            }else {
                                comment.near_id=0;
                            }
                        }else if ([@"title" isEqual:cur3_name]) {
                            if (cur3_node->children != nil)  {
                                NSString * content = [NSString stringWithUTF8String:(char *)cur3_node->children->content];
                                comment.near_title =content;
                                
                            }else {
                                comment.near_title=@"";
                            }
                        }else if ([@"count" isEqual:cur3_name]) {
                            if (cur3_node->children != nil)  {
                                NSString * content = [NSString stringWithUTF8String:(char *)cur3_node->children->content];
                                comment.near_count =[content integerValue];
                                
                            }else {
                                comment.near_count=0;
                            }
                        }
                        
                    }
                }
			}
            [_commentArr addObject:comment];
            [comment release];
		}
	}
	xmlFreeDoc(doc);
	//[pool release];
	return YES;
}


@end
