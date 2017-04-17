//
//  NSString+stripXml.m
//  iBadajoz
//
//  Created by David Cordero on 26/09/13.
//  Copyright (c) 2013 David Cordero. All rights reserved.
//

#import "NSMutableString+stripXml.h"

@implementation NSString (stripXml)

- (NSString *)xmlSimpleUnescapeString
{
    NSMutableString *unescapeStr = [NSMutableString stringWithString:self];
    
    return [unescapeStr xmlSimpleUnescape];
}


- (NSString *)xmlSimpleEscapeString
{
    NSMutableString *escapeStr = [NSMutableString stringWithString:self];
    
    return [escapeStr xmlSimpleEscape];
}

@end
