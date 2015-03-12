//
//  RRRainbow.h
//  RRRainbow
//
//  Created by Admin on 3/9/15.
//  Copyright (c) 2015 ramsel. All rights reserved.
//

#import <UIKit/UIKit.h>
//
//typedef NS_ENUM(NSUInteger, RRColorPositionIndex) {
//    RRColorPositionRed,
//    RRColorPositionOrange,
//    RRColorPositionYellow,
//    RRColorPositionGreen,
//    RRColorPositionBlue,
//    RRColorPositionPurple
//};

/** Parameters **/
//#define TB_SLIDER_WIDTH 320                         //The width of the slider
//#define TB_SLIDER_HEIGHT 160                        //The height of the slider
//#define TB_BACKGROUND_WIDTH 60                      //The width of the dark background
//#define TB_LINE_WIDTH 20                            //The width of the active area (the gradient) and the width of the handle

@interface RRRainbow : UIControl

/**
 * Designated initializer
 */
- (instancetype)initWithWidth:(CGFloat)width;

/**
 * @warning An RRRainbow's height half it's width. initWithFrame will take the width of the passed frame and calculate a height = width/2
 */
- (instancetype)initWithFrame:(CGRect)frame;


@property (nonatomic, assign)int angle;

@end
