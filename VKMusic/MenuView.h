//
//  MenuView.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 3/16/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuView : UIView
{
    UILabel *titleLabel;
}

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) UIView *contentView;

@end
