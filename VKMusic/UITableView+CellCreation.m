//
//  UITableView+CellCreation.m
//  WorldlifeNMP
//
//  Created by Evgeniy Kirpichenko on 7/5/12.
//  Copyright (c) 2012 MLS. All rights reserved.
//

#import "UITableView+CellCreation.h"

@implementation UITableView (CellCreation)

- (id) cellForClass:(Class) CellClass {
    if (![CellClass isSubclassOfClass:[UITableViewCell class]]) {
        NSString *className = NSStringFromClass(CellClass);
        [NSException raise:@"Wrong class"
                    format:@"%@ is not subclass of UITableViewCell",className];
    }
    
    NSString* cellIdentifier = NSStringFromClass(CellClass);
    UITableViewCell* cell = [self dequeueReusableCellWithIdentifier:cellIdentifier];    
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:cellIdentifier 
                                                                 owner:nil 
                                                               options:nil];
        for(id currentObject in topLevelObjects) {
            if([currentObject isKindOfClass:CellClass]) {
                return currentObject;
            }           
        }
    }
    
    return cell;
}

- (UITableViewCell *) baseCellWithStyle:(UITableViewCellStyle) style 
                             identifier:(NSString *) identifier 
{
    UITableViewCell* cell = [self dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:style reuseIdentifier:identifier];
    }
    
    return cell;
}

- (UITableViewCell *) baseCellWithIdentifier:(NSString *) identifier {
    return [self baseCellWithStyle:UITableViewCellStyleDefault identifier:identifier];
}

@end
