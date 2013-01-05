//
//  NSDictionary+LoadFromJsonFile.h
//  CommandCenter-iPad
//
//  Created by Evgeniy Kirpichenko on 8/1/12.
//  Copyright (c) 2012 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (LoadFromJsonFile)
+ (NSDictionary *) dictionaryFromJsonFileNamed:(NSString *)fileName;
+ (NSDictionary *) dictionaryFromJsonString:(NSString *) jsonString;
@end
