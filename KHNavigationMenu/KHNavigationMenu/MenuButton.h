//
//  MenuButton.h
//  RWBlurPopoverDemo
//
//  Created by Khan on 14-10-22.
//  Copyright (c) 2014年 Khan.Lau. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuButton : UIControl


@property (nonatomic, unsafe_unretained) BOOL isActive;
@property (nonatomic) CGGradientRef spotlightGradientRef;
@property (unsafe_unretained) CGFloat spotlightStartRadius;
@property (unsafe_unretained) float spotlightEndRadius;
@property (unsafe_unretained) CGPoint spotlightCenter;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIImageView *arrow;

- (UIImageView *)defaultGradient;

@end
