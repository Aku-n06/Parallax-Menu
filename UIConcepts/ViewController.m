//
//  ViewController.m
//  UIConcepts
//
//  Created by Alberto Scampini on 05/11/2015.
//  Copyright © 2015 Alberto Scampini. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //add observer to menu item selected from LTParallaxMenu
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuItemSelected:) name:MENUITEMSELECTED object:nil];
    //add observer to slider control
    [self.slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
}

- (IBAction)sliderValueChanged:(UISlider *)sender {
    [self.controlsView setOpenValue:@(sender.value)];
}

- (void)menuItemSelected:(NSNotification *)notification {
    NSLog(@"button %d selected", (int)[notification.object integerValue]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
