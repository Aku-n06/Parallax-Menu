//
//  ViewController1.h
//  UIConcepts
//
//  Created by Alberto Scampini on 05/11/2015.
//  Copyright © 2015 Alberto Scampini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASParallaxMenu.h"

@interface ViewController1 : UIViewController <UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, weak) IBOutlet ASParallaxMenu *controlsView;

@property (nonatomic, weak) IBOutlet UITableView *table;

@end
