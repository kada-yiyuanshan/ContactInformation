//
//  HomeImageIdXMLParse.m
//  PaiGo
//
//  Created by perry on 12-11-14.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import "HomeImageIdXMLParse.h"
#import "ErrorBean.h"
#import "HomeImageIdBean.h"

@implementation HomeImageIdXMLParse

+(BOOL) parseArrXML:(NSString *)xml commentArr:(NSMutableArray*)_commentArr errorBean:(ErrorBean *)_error;
{
	
    //NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	xmlDocPtr doc = xmlParseMemory([xml UTF8String], [xml lengthOfBytesUsingEncoding:NSUTF8StringEncoding]);
	if(doc ==nil)
	{
		[NSException raise:NSGenericException format:@"xml error"];
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
			HomeImageIdBean *comment = [[HomeImageIdBean alloc] init];
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
                                comment.name =content;
                                
                            }else {
                                comment.name=0;
                            }
                        }else if ([@"address" isEqual:cur3_name]) {
                            if (cur3_node->children != nil)  {
                                NSString * content = [NSString stringWithUTF8String:(char *)cur3_node->children->content];
                                comment.address =content;
                                
                            }else {
                                comment.address=@"";
                            }
                        }else if ([@"phone" isEqual:cur3_name]) {
                            if (cur3_node->children != nil)  {
                                NSString * content = [NSString stringWithUTF8String:(char *)cur3_node->children->content];
                                comment.phone =[content integerValue];
                                
                            }else {
                                comment.phone=0;
                            }
                        }else if ([@"merchant_pic" isEqual:cur3_name]) {
                            if (cur3_node->children != nil)  {
                                NSString * content = [NSString stringWithUTF8String:(char *)cur3_node->children->content];
                                comment.merchant_pic =content;
                                
                            }else {
                                comment.merchant_pic=@"";
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
                                comment._id =[content intValue];
                                
                            }else {
                                comment._id=0;
                            }
                        }else if ([@"title" isEqual:cur3_name]) {
                            if (cur3_node->children != nil)  {
                                NSString * content = [NSString stringWithUTF8String:(char *)cur3_node->children->content];
                                comment.title =content;
                                
                            }else {
                                comment.title=@"";
                            }
                        }else if ([@"start" isEqual:cur3_name]) {
                            if (cur3_node->children != nil)  {
                                NSString * content = [NSString stringWithUTF8String:(char *)cur3_node->children->content];
                                comment.start_time =content;
                                
                            }else {
                                comment.start_time=@"";
                            }
                        }else if ([@"end" isEqual:cur3_name]) {
                            if (cur3_node->children != nil)  {
                                NSString * content = [NSString stringWithUTF8String:(char *)cur3_node->children->content];
                                comment.end_time =content;
                                
                            }else {
                                comment.end_time=@"";
                            }
                        }else if ([@"count" isEqual:cur3_name]) {
                            if (cur3_node->children != nil)  {
                                NSString * content = [NSString stringWithUTF8String:(char *)cur3_node->children->content];
                                comment.count =[content integerValue];
                                
                            }else {
                                comment.count=0;
                            }
                        }else if ([@"name" isEqual:cur3_name]) {
                            if (cur3_node->children != nil)  {
                                NSString * content = [NSString stringWithUTF8String:(char *)cur3_node->children->content];
                                comment.name_pic =content;
                                
                            }else {
                                comment.name_pic=@"";
                            }
                        }else if ([@"other" isEqual:cur3_name]) {
                            if (cur3_node->children != nil)  {
                                NSString * content = [NSString stringWithUTF8String:(char *)cur3_node->children->content];
                                comment.other =content;
                                
                            }else {
                                comment.other=@"";
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
