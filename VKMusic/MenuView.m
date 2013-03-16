//
//  MenuView.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 3/16/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "MenuView.h"

static const float kTitleHeight = 20;
static const float kTitleFontSize = 12;

@implementation MenuView

#pragma mark -
#pragma mark life cycle

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self createTitleLabel];
}

- (void)createTitleLabel
{
    titleLabel = [[UILabel alloc] init];
    [titleLabel setBackgroundColor:[UIColor blackColor]];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:kTitleFontSize]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];

    [self addSubview:titleLabel];
}

#pragma mark -
#pragma mark accessory

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    [titleLabel setText:title];
}

- (void)setContentView:(UIView *)contentView
{
    _contentView = contentView;

    [self addSubview:contentView];
    [self setNeedsLayout];
}

#pragma mark -
#pragma mark layout

- (void)layoutSubviews
{
    CGRect titleFrame = CGRectMake(0, 0, [self frame].size.width, kTitleHeight);
    [titleLabel setFrame:titleFrame];
    
    CGRect contentFrame = [self bounds];
    contentFrame.origin.y = kTitleHeight;
    contentFrame.size.height -= kTitleHeight;
    [[self contentView] setFrame:contentFrame];
}

@end
