//
//  AudioProgressView.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/13/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "AudioProgressView.h"

@interface AudioProgressView ()
@property (nonatomic) CGFloat progress;
@end

@implementation AudioProgressView

- (void) setProgress:(CGFloat) progress
{
    if (progress != [self progress]) {
        _progress = progress;
        [self setNeedsDisplay];
    }
}

- (void) drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    
    CGRect progressRect = [self bounds];
    progressRect.size.width = progressRect.size.width * [self progress];
    
    CGContextFillRect(context, progressRect);
}

@end
