//
//  UITableView+CellCreation.h
//  WorldlifeNMP
//
//  Created by Evgeniy Kirpichenko on 7/5/12.
//  Copyright (c) 2012 MLS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (CellCreation)
- (id) cellForClass:(Class) cellClass;
- (UITableViewCell *) baseCellWithStyle:(UITableViewCellStyle) style 
                             identifier:(NSString *) identifier;
- (UITableViewCell *) baseCellWithIdentifier:(NSString *) identifier;
@end
