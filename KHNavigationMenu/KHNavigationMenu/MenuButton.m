//
//  MenuButton.m
//  RWBlurPopoverDemo
//
//  Created by Khan on 14-10-22.
//  Copyright (c) 2014年 Khan.Lau. All rights reserved.
//

#import "MenuButton.h"
#import "MenuConfiguration.h"

@implementation MenuButton

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        if ([self defaultGradient]) {
            
        } else {
            [self setSpotlightCenter:CGPointMake(frame.size.width/2, frame.size.height*(-1)+10)];
            [self setBackgroundColor:[UIColor clearColor]];
            [self setSpotlightStartRadius:0];
            [self setSpotlightEndRadius:frame.size.width/2];
        }
        
        frame.origin.y -= 2.0;
        self.title = [[UILabel alloc] initWithFrame:frame];
        
        self.title.textAlignment   = NSTextAlignmentLeft;
        
        self.title.backgroundColor = [UIColor clearColor];
        
        NSDictionary *currentStyle = [[UINavigationBar appearance] titleTextAttributes];
        if( currentStyle ){
            self.title.textColor       = currentStyle[NSForegroundColorAttributeName];
            self.title.font            = currentStyle[NSFontAttributeName];
            
            NSShadow *shadow           = currentStyle[NSShadowAttributeName];
            self.title.shadowColor     = shadow.shadowColor;
            self.title.shadowOffset    = shadow.shadowOffset;
        } else {
            self.title.textColor = [UIColor whiteColor];
        }
        [self addSubview:self.title];
        
        self.arrow = [[UIImageView alloc] initWithImage:[MenuConfiguration arrowImage]];
        [self addSubview:self.arrow];
    }
    return self;
}

- (UIImageView *)defaultGradient {
    return nil;
}

- (void)layoutSubviews {
//    [self.title sizeToFit];
//    CGRect r = self.title.frame;
//    self.title.center = CGPointMake(self.frame.size.width/2, (self.frame.size.height-2.0)/2);
//
//    self.arrow.center = CGPointMake(CGRectGetMaxX(self.title.frame) + [MenuConfiguration arrowPadding], self.frame.size.height / 2);
    
    [self.title sizeToFit];
    CGRect r = self.title.frame;
    CGRect rect = self.title.frame;
    if (self.title.frame.size.width > 180) {
        rect.size.width = 180;
        self.title.frame = rect;
    }
    self.title.center = CGPointMake(self.frame.size.width/2, (self.frame.size.height-2.0)/2);
    
    r.origin.y = self.title.frame.origin.y;
    r.size.width = self.title.frame.size.width;
    r.size.height = self.title.frame.size.height;
    self.title.frame = r;

    self.arrow.center = CGPointMake(CGRectGetMaxX(self.title.frame) + [MenuConfiguration arrowPadding], self.frame.size.height / 2);
}

#pragma mark -
#pragma mark Handle taps
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    self.isActive = !self.isActive;
    CGGradientRef defaultGradientRef = [[self class] newSpotlightGradient];
    [self setSpotlightGradientRef:defaultGradientRef];
    CGGradientRelease(defaultGradientRef);
    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    self.spotlightGradientRef = nil;
}

- (void)cancelTrackingWithEvent:(UIEvent *)event {
    self.spotlightGradientRef = nil;
}

#pragma mark - Drawing Override
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGGradientRef gradient = self.spotlightGradientRef;
    float radius = self.spotlightEndRadius;
    float startRadius = self.spotlightStartRadius;
    CGContextDrawRadialGradient (context, gradient, self.spotlightCenter, startRadius, self.spotlightCenter, radius, kCGGradientDrawsAfterEndLocation);
}


#pragma mark - Factory Method

+ (CGGradientRef)newSpotlightGradient {
    size_t locationsCount = 2;
    CGFloat locations[2] = {1.0f, 0.0f,};
    CGFloat colors[12] = {0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.55f};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, colors, locations, locationsCount);
    CGColorSpaceRelease(colorSpace);
    
    return gradient;
}

- (void)setSpotlightGradientRef:(CGGradientRef)newSpotlightGradientRef {
    CGGradientRelease(_spotlightGradientRef);
    _spotlightGradientRef = nil;
    
    _spotlightGradientRef = newSpotlightGradientRef;
    CGGradientRetain(_spotlightGradientRef);
    
    [self setNeedsDisplay];
}

#pragma mark - Deallocation

- (void)dealloc {
    [self setSpotlightGradientRef:nil];
}


@end
