//
//  NSString+Hash.h
//  ImageFilesManager
//
//  Created by Evgeniy Kirpichenko on 10/5/12.
//  Copyright (c) 2012 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Hash)

- (NSString *) sha1;
- (NSString *) md5;

@end
