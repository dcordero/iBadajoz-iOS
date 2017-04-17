//
//  NSString+stripXml.h
//  iBadajoz
//
//  Created by David Cordero on 26/09/13.
//  Copyright (c) 2013 David Cordero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (stripXml)

- (NSString *)xmlSimpleUnescapeString;

- (NSString *)xmlSimpleEscapeString;

@end
