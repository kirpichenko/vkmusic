//
//  NSString+Hash.m
//  ImageFilesManager
//
//  Created by Evgeniy Kirpichenko on 10/5/12.
//  Copyright (c) 2012 Evgeniy Kirpichenko. All rights reserved.
//

#import "NSString+Hash.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (Hash)

- (NSString *) sha1
{
    const char *cStr = [self UTF8String];
    unsigned char result[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(cStr, strlen(cStr), result);
    
    NSMutableString *sha1String = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; ++i) {
        [sha1String appendFormat:@"%02x",result[i]];
    }
    return sha1String;
}

- (NSString *) md5
{
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), result );
    
    NSMutableString *md5String = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; ++i) {
        [md5String appendFormat:@"%02x",result[i]];
    }
    return md5String;  
}

@end
