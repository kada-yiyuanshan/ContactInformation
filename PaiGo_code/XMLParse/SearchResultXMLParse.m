//
//  SearchResultXMLParse.m
//  PaiGo
//
//  Created by perry on 12-11-13.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import "SearchResultXMLParse.h"
#import "ErrorBean.h"
#import "SearchBean.h"

@implementation SearchResultXMLParse


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
		}else if([cur_name isEqual:@"counts"])
        {
                if (cur_node->children != nil)  {
                    NSString *content = [NSString stringWithUTF8String:(char *)cur_node->children->content];
                    _error.counts= [content integerValue];
                }else {
                    _error.counts = 0;
                }
        }else if([cur_name isEqual:@"pages"])
        {
                if (cur_node->children != nil)  {
                    NSString *content = [NSString stringWithUTF8String:(char *)cur_node->children->content];
                    _error.pages= [content integerValue];
                }else {
                    _error.pages = 0;
                }
        }else if([cur_name isEqual:@"product"])
		{
			
			xmlNodePtr c2_node =cur_node->children;
			xmlNodePtr cur2_node;
			SearchBean *comment = [[SearchBean alloc] init];
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
                                comment.name_product =content;
                                
                            }else {
                                comment.name_product=0;
                            }
                        }else if ([@"address" isEqual:cur3_name]) {
                            if (cur3_node->children != nil)  {
                                NSString * content = [NSString stringWithUTF8String:(char *)cur3_node->children->content];
                                comment.address_product =content;
                                
                            }else {
                                comment.address_product=@"";
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
                                comment.id_product =[content integerValue];
                                
                            }else {
                                comment.id_product=0;
                            }
                        }else if ([@"title" isEqual:cur3_name]) {
                            if (cur3_node->children != nil)  {
                                NSString * content = [NSString stringWithUTF8String:(char *)cur3_node->children->content];
                                comment.title_product =content;
                                
                            }else {
                                comment.title_product=@"";
                            }
                        }else if ([@"count" isEqual:cur3_name]) {
                            if (cur3_node->children != nil)  {
                                NSString * content = [NSString stringWithUTF8String:(char *)cur3_node->children->content];
                                comment.count_product =[content integerValue];
                                
                            }else {
                                comment.count_product=0;
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
