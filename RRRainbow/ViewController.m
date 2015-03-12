//
//  ViewController.m
//  RRRainbow
//
//  Created by Admin on 3/9/15.
//  Copyright (c) 2015 ramsel. All rights reserved.
//
//  Credit to https://github.com/ariok/TB_CircularSlider as a starting point

#import "ViewController.h"
#import "RRRainbow.h"

/** Parameters **/
#define RR_RAINBOW_WIDTH 280

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Setup rainbow
    RRRainbow* rainbow = [[RRRainbow alloc] initWithWidth:RR_RAINBOW_WIDTH];
    rainbow.center = self.view.center;
    [self.view addSubview:rainbow];
    
    [rainbow addTarget:self action:@selector(rainbowed:) forControlEvents:UIControlEventValueChanged];
}


#pragma mark - Actions -
-(void)rainbowed:(RRRainbow*)rainbow{
    
}
@end
