//
//  RRRainbow.m
//  RRRainbow
//
//  Created by Admin on 3/9/15.
//  Copyright (c) 2015 ramsel. All rights reserved.
//

#import "RRRainbow.h"

/** Helper Functions **/
#define ToRad(deg) 		( (M_PI * (deg)) / 180.0 )
#define ToDeg(rad)		( (180.0 * (rad)) / M_PI )
#define SQR(x)			( (x) * (x) )

/** Parameters **/
#define RR_NUM_COLORS 6


@interface RRRainbow () {
    
    // Dimensions
    int radius;
    int lineWidth;
    int outsidePadding;
    int insidePadding;
    
}

@end

@implementation RRRainbow

- (instancetype)initWithWidth:(CGFloat)width
{
    self = [super initWithFrame:[RRRainbow rectForWidth:width]];
    if (self) {
        
        self.opaque = NO;
        
        // Default outsidePadding & insidePadding
        outsidePadding = self.frame.size.height / (RR_NUM_COLORS + 2);
        insidePadding = self.frame.size.height / (RR_NUM_COLORS + 2);
        
        // Define the line width
        lineWidth = [self heightMinusInsideAndOutsidePadding] / RR_NUM_COLORS;
        
        // Initialize the Angle at 0
        self.angle = 180;
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithWidth:frame.size.width];
}

#pragma mark - UIControl Override -
/** Tracking is started **/
-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super beginTrackingWithTouch:touch withEvent:event];
    
    //We need to track continuously
    return YES;
}



/** Track continuos touch event (like drag) **/
-(BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    
    [super continueTrackingWithTouch:touch withEvent:event];
    
    // Get touch location
    CGPoint point = [touch locationInView:self];

    // Use the location to draw the rainbow
    [self drawRainbow:point];

    // Control value has changed, let's notify that
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    
    return YES;
}

/** Track is finished **/
-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super endTrackingWithTouch:touch withEvent:event];
    
}


#pragma mark - Drawing Functions -
//Use the draw rect to draw the Background, the Circle and the Handle
-(void)drawRect:(CGRect)rect{
    
    [super drawRect:rect];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // Define the starting radius taking into account the safe area
    radius = self.frame.size.height - outsidePadding;
    
    /** Draw the Colored Arcs **/
    for (int i = 0; i < RR_NUM_COLORS; i++) {
             
        CGContextAddArc(ctx, self.frame.size.width/2, self.frame.size.height, radius, ToRad(180), ToRad(self.angle), 0);
        
        //Set the stroke color
        UIColor* currentColor = [self colorForPosition:i];
        [currentColor setStroke];
        
        //Define line width and cap
        CGContextSetLineWidth(ctx, lineWidth);
        CGContextSetLineCap(ctx, kCGLineCapButt);
        
        //draw it!
        CGContextDrawPath(ctx, kCGPathStroke);
        
        // update currentRadius
        radius = radius - lineWidth;
    }
}


#pragma mark - Math -
-(void)drawRainbow:(CGPoint)point{
    
    // Get the center
    CGPoint centerPoint = CGPointMake(self.frame.size.width/2, self.frame.size.height);
    
    // Calculate the direction from a center point and a arbitrary position.
    float currentAngle = AngleFromNorth(centerPoint, point, NO);
    int angleInt = floor(currentAngle);
    
    
    // Store the new angle if within the rainbow arc
    if (angleInt < 190 || angleInt > 350) { // Keep a buffer of 10 degree on either side to catch fast swipes
        self.angle = angleInt + 180;
    }


    // Redraw
    [self setNeedsDisplay];
}


/** Given the angle, get the point position on circumference **/
-(CGPoint)pointFromAngle:(int)angleInt{
    
    //Circle center
    CGPoint centerPoint = CGPointMake(self.frame.size.width/2 - lineWidth/2, self.frame.size.height - lineWidth/2);
    
    //The point position on the circumference
    CGPoint result;
    result.y = round(centerPoint.y + radius * sin(ToRad(angleInt))) ;
    result.x = round(centerPoint.x + radius * cos(ToRad(angleInt)));
    
    return result;
}

//Sourcecode from Apple example clockControl
//Calculate the direction in degrees from a center point to an arbitrary position.
static inline float AngleFromNorth(CGPoint p1, CGPoint p2, BOOL flipped) {
    
    CGPoint v = CGPointMake(p2.x-p1.x,p2.y-p1.y);
    float vmag = sqrt(SQR(v.x) + SQR(v.y)), result = 0;
    
    v.x /= vmag;
    v.y /= vmag;
    double radians = atan2(v.y,v.x);
    result = ToDeg(radians);
    
    return result + 180;
}


#pragma mark - Colors -
- (UIColor*)colorForPosition:(int)position {
    
    switch (position) {
        case 0:
            return [UIColor redColor];
            break;
            
        case 1:
            return [UIColor orangeColor];
            break;
            
        case 2:
            return [UIColor yellowColor];
            break;
            
        case 3:
            return [UIColor greenColor];
            break;
            
        case 4:
            return [UIColor blueColor];
            break;
            
        case 5:
            return [UIColor purpleColor];
            break;
            
        default:
            return nil;
            break;
    }
    
}

#pragma mark - Layout -
+ (CGRect)rectForWidth:(CGFloat)width {
    return CGRectMake(0.0f,
                      0.0f,
                      width,
                      width/2.0f);
}

- (CGFloat)heightMinusInsideAndOutsidePadding {
    return CGRectGetHeight(self.frame) - outsidePadding - insidePadding;
}


@end


