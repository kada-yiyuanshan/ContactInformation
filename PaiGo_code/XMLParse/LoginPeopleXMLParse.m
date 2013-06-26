//
//  LoginPeopleXMLParse.m
//  PaiGo
//
//  Created by perry on 12-11-12.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import "LoginPeopleXMLParse.h"
#import "ErrorBean.h"
#import "LoginPeopleBean.h"

@implementation LoginPeopleXMLParse

+(BOOL) parseArrXML:(NSString *)xml commentArr:(NSMutableArray*)_commentArr errorBean:(ErrorBean*)_error;
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
	
	//LoginBean *loginBean = [[LoginBean alloc] init];
	
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
		}else if([@"user" isEqual:cur_name])
                {
                LoginPeopleBean *comment = [[LoginPeopleBean alloc] init];
                    xmlNodePtr c2_node =cur_node->children;
                    xmlNodePtr cur2_node;
                    for(cur2_node = c2_node;cur2_node;cur2_node=cur2_node->next)
                    {
                        NSString *cur2_name = [NSString stringWithUTF8String:(char *)cur2_node->name];
                        if ([@"id" isEqual:cur2_name]) {
                            if (cur2_node->children != nil)  {
                                NSString * content = [NSString stringWithUTF8String:(char *)cur2_node->children->content];
                                comment.uesr_id =[content intValue];
                                
                            }else {
                                comment.uesr_id=0;
                            }
                        }else if ([@"username" isEqual:cur2_name]) {
                            if (cur2_node->children != nil)  {
                                NSString * content = [NSString stringWithUTF8String:(char *)cur2_node->children->content];
                                comment.username =content;
                            }else {
                                comment.username=@"";
                            }
                        }else if ([@"name" isEqual:cur2_name]) {
                            if (cur2_node->children != nil)  {
                                NSString * content = [NSString stringWithUTF8String:(char *)cur2_node->children->content];
                                comment.name =content;
                            }else {
                                comment.name=@"";
                            }
                        }else if ([@"cell_phone" isEqual:cur2_name]) {
                            if (cur2_node->children != nil)  {
                                NSString * content = [NSString stringWithUTF8String:(char *)cur2_node->children->content];
                                comment.cell_phone =content;
                            }else {
                                comment.cell_phone=@"";
                            }
                        }else {
                    }
                }
                    
                    [_commentArr addObject:comment];
                    [comment release];
        }
    }
    xmlFreeDoc(doc);
    return YES;
}
@end

