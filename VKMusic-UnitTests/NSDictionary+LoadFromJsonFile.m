//
//  NSDictionary+LoadFromJsonFile.m
//  CommandCenter-iPad
//
//  Created by Evgeniy Kirpichenko on 8/1/12.
//  Copyright (c) 2012 Evgeniy Kirpichenko. All rights reserved.
//

#import "NSDictionary+LoadFromJsonFile.h"
#import "SBJsonParser.h"

@implementation NSDictionary (LoadFromJsonFile)

+ (NSDictionary *) dictionaryFromJsonFileNamed:(NSString *)fileName {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    NSError *error = nil;
    NSString *fileString = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    
    if (error == nil) {
        return [self dictionaryFromJsonString:fileString];
    }
    
    return nil;
}

+ (NSDictionary *) dictionaryFromJsonString:(NSString *) jsonString {
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *parsedDictionary = [parser objectWithString:jsonString];
    
    if ([parsedDictionary isKindOfClass:[NSDictionary class]]) {
        return parsedDictionary;
    }
    
    return nil;
}

@end
