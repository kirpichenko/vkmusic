//
//  ApiRequestBuilder.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 2/17/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AudioSearchApiRequest.h"
#import "AudioGetApiRequest.h"
#import "AlbumsGetApiRequest.h"

@interface ApiRequestManager : NSObject
{
    NSDictionary *apiPaths;
}

- (id)apiRequestTemplateOfClass:(Class)ApiRequestClass;

@end
