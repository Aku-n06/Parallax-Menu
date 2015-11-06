//
//  ASParallaxMenu.h
//  UIConcepts
//
//  Created by Alberto Scampini on 05/11/2015.
//  Copyright © 2015 Alberto Scampini. All rights reserved.
//

#import <UIKit/UIKit.h>

#define HEIGHTOFFSET 200 //height difference from open to close
#define MENUITEMSELECTED @"menu_item_selected" //notification

@interface ASParallaxMenu : UIView

- (void)setOpenValue:(NSNumber *)multiplier;

@end
