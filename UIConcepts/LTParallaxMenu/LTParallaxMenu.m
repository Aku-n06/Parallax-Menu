//
//  LTParallaxMenu.m
//  UIConcepts
//
//  Created by Alberto Scampini on 05/11/2015.
//  Copyright © 2015 Alberto Scampini. All rights reserved.
//

#import "LTParallaxMenu.h"
#import "LTParallaxItem.h"

@interface LTParallaxMenu ()

@property (nonatomic, retain) UIView *contentView;
@property (nonatomic, retain) NSNumber *originY;

@end

@implementation LTParallaxMenu {
    NSMutableArray *animationsArray;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self animationInit];
        [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(recordStartingPositions) userInfo:nil repeats:NO];
    }
    return self;
}

#pragma mark - prepare for animation

- (void)animationInit {
    UIView *xibView = nil;
    //load xib
    NSLog(@"%@", [NSBundle mainBundle]);
    NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"LTParallaxMenuView"
                                                     owner:self
                                                   options:nil];
    //verify
    for (id object in objects) {
        if ([object isKindOfClass:[UIView class]]) {
            xibView = object;
            break;
        }
    }
    //apply
    if (xibView != nil) {
        xibView.frame = self.bounds;
        [self addSubview:xibView];
        [self setNeedsUpdateConstraints];
        self.originY = [NSNumber numberWithFloat:self.frame.origin.y];
        //get and hide contentView
        self.contentView = [xibView viewWithTag:999];
        self.contentView.alpha = 0;
    }
}

- (void)recordStartingPositions {
    //init array
    animationsArray = [NSMutableArray new];
    //search in all subviews for menu views (menu items): tag from 1 to 99
    for (UIView *openedItem in [self.contentView subviews]){
        if (openedItem.tag > 0 && openedItem.tag < 100) {
            LTParallaxItem *newItem =[LTParallaxItem new];
            //register start state
            float xOpen = openedItem.frame.origin.x;
            float yOpen = openedItem.frame.origin.y;
            newItem.tagOpen = [NSNumber numberWithInt:(int) openedItem.tag];
            float alphaOpen = openedItem.alpha;
            //get end view and register final state
            UIView *closedItem = [self viewWithTag:openedItem.tag + 100];
            newItem.xClose = [NSNumber numberWithFloat:closedItem.frame.origin.x];
            newItem.yClose = [NSNumber numberWithFloat:closedItem.frame.origin.y + HEIGHTOFFSET];
            newItem.widthClose = [NSNumber numberWithFloat:closedItem.frame.size.width];
            newItem.heightClose = [NSNumber numberWithFloat:closedItem.frame.size.height];
            newItem.alphaClose = [NSNumber numberWithFloat:closedItem.alpha];
            //calculate deltas
            newItem.alphaDelta = [NSNumber numberWithFloat:alphaOpen - closedItem.alpha];
            newItem.xDelta = [NSNumber numberWithFloat:(xOpen - [newItem.xClose floatValue])];
            newItem.yDelta = [NSNumber numberWithFloat:(yOpen - [newItem.yClose floatValue])];
            [animationsArray addObject:newItem];
            //remove prototype view
            [closedItem removeFromSuperview];
        }
    }
    //begin
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(beginPosition) userInfo:nil repeats:NO];
    [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(beginShow) userInfo:nil repeats:NO];
}

#pragma mark - animate

- (void)beginPosition {
    [self setOpenValue:@(1)];
}

- (void)beginShow {
    [UIView animateWithDuration:0.1 animations:^{
        self.contentView.alpha = 1;
    }];
}

- (void)setOpenValue:(NSNumber *)multiplier {
    [UIView animateWithDuration:0.1 animations:^{
        //controls
         for (LTParallaxItem *menuItem in animationsArray){
             UIView *menuView = [self viewWithTag:[menuItem.tagOpen integerValue]];
             menuView.frame = CGRectMake([menuItem.xClose floatValue] + ([menuItem.xDelta floatValue] * [multiplier floatValue]),
                                         [menuItem.yClose floatValue] + ([menuItem.yDelta floatValue] * [multiplier floatValue]),
                                         [menuItem.widthClose floatValue],
                                         [menuItem.heightClose floatValue]);
             menuView.alpha = [menuItem.alphaClose floatValue] + ([menuItem.alphaDelta floatValue] * [multiplier floatValue]);
             
         }
        
        //resize container
        self.frame = CGRectMake(self.frame.origin.x,
                                [self.originY floatValue] - HEIGHTOFFSET * (1 - [multiplier floatValue]),
                                self.frame.size.width,
                                self.frame.size.height);
     }];
}

@end
