//
//  MenuConfiguration.m
//  RWBlurPopoverDemo
//
//  Created by Khan on 14-10-22.
//  Copyright (c) 2014年 Khan.Lau. All rights reserved.
//

#import "MenuConfiguration.h"

@implementation MenuConfiguration


//Menu width
+ (float)menuWidth {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    return window.frame.size.width;
}


//Animation duration of menu appearence
+ (float)animationDuration {
    return 0.3f;
}



//Arrow image near title
+ (UIImage *)arrowImage {
    return [UIImage imageNamed:@"arrow_gray"];
}


//Distance between Title and arrow image
+ (float)arrowPadding {
    return 13.0;
}


@end
