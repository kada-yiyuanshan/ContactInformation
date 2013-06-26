//
//  CommentXMLParse.m
//  App
//
//  Created by leo on 9/24/12.
//
//

#import "CommentXMLParse.h"

#import "ContentBean.h"  
   
@implementation CommentXMLParse

+(BOOL) parseArrXML:(NSString *)xml commentArr:(NSMutableArray*)_commentArr;
{
	
	xmlDocPtr doc = xmlParseMemory([xml UTF8String], [xml lengthOfBytesUsingEncoding:NSUTF8StringEncoding]);
	if(doc ==nil)
	{
		[NSException raise:NSGenericException format:@"xml error"];
	}
	xmlNodePtr root = xmlDocGetRootElement(doc);
	
	xmlNodePtr node = root->children;
	
	xmlNodePtr cur_node;
    
    for(cur_node = node;cur_node;cur_node=cur_node->next)
       {
        NSString *cur_name = [NSString stringWithUTF8String:(char *)cur_node->name];
        if([@"student" isEqual:cur_name]){
            ContentBean *contentbean = [[ContentBean alloc] init];
            xmlNodePtr c2_node =cur_node->children;
            xmlNodePtr cur2_node;
          for(cur2_node = c2_node;cur2_node;cur2_node=cur2_node->next)
            {
               NSString *cur2_name = [NSString stringWithUTF8String:(char *)cur2_node->name];
                if ([@"firstname" isEqual:cur2_name]) {
                    if (cur2_node->children != nil)
                    {
                    NSString * content = [NSString stringWithUTF8String:(char *)cur2_node->children->content];
                                                  
                        contentbean.firstname =content;
                                                  
                     }else {
                        contentbean.firstname=@"";
                        }
                }else if ([@"lastname" isEqual:cur2_name]) {
                    if (cur2_node->children != nil)  {
                    NSString * content = [NSString stringWithUTF8String:(char *)cur2_node->children->content];
                                
                        contentbean.lastname=content;
                                
                    }else {
                        contentbean.lastname=@"";
                        }
                }else if ([@"gender" isEqual:cur2_name]) {
                    if (cur2_node->children != nil)  {
                    NSString * content = [NSString stringWithUTF8String:(char *)cur2_node->children->content];
                                    
                        contentbean.gender =content;
                                    
                    }else {
                        contentbean.gender=@"";
                         }
                }else if ([@"phone" isEqual:cur2_name]) {
                    if (cur2_node->children != nil)  {
                    NSString * content = [NSString stringWithUTF8String:(char *)cur2_node->children->content];
                        contentbean.phone =[content intValue];
                                
                    }else {
                        contentbean.phone=0;
                        }
                }else if ([@"Email" isEqual:cur2_name]) {
                    if (cur2_node->children != nil)  {
                    NSString * content = [NSString stringWithUTF8String:(char *)cur2_node->children->content];
                            
                        contentbean.email =content;
                                
                    }else {
                        contentbean.email=@"";
                        }
                }else if ([@"address" isEqual:cur2_name]) {
                    if (cur2_node->children != nil)  {
                    NSString * content = [NSString stringWithUTF8String:(char *)cur2_node->children->content];
                            
                        contentbean.address =content;
                            
                    }else {
                        contentbean.address=@"";
                    }
                }
                        
            }
                [_commentArr addObject:contentbean];
                [contentbean release];
            }
        }

	
	
	xmlFreeDoc(doc);
	//[pool release];
	return YES;
}
@end
