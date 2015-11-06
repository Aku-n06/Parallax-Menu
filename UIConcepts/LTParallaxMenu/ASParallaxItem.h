//
//  ASParallaxItem.h
//  UIConcepts
//
//  Created by Alberto Scampini on 05/11/2015.
//  Copyright © 2015 Alberto Scampini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASParallaxItem : NSObject

@property (nonatomic, retain) NSNumber *xClose;
@property (nonatomic, retain) NSNumber *yClose;

@property (nonatomic, retain) NSNumber *xDelta;
@property (nonatomic, retain) NSNumber *yDelta;

@property (nonatomic, retain) NSNumber *widthClose;
@property (nonatomic, retain) NSNumber *heightClose;
@property (nonatomic, retain) NSNumber *tagOpen;

@property (nonatomic, retain) NSNumber *alphaDelta;
@property (nonatomic, retain) NSNumber *alphaClose;


@end
