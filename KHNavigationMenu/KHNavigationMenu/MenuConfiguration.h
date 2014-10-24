//
//  MenuConfiguration.h
//  RWBlurPopoverDemo
//
//  Created by Khan on 14-10-22.
//  Copyright (c) 2014年 Khan.Lau. All rights reserved.
//

@import UIKit;

@interface MenuConfiguration : NSObject


//Menu width
+ (float)menuWidth;


//Animation duration of menu appearence
+ (float)animationDuration;


//Arrow image near title
+ (UIImage *)arrowImage;

//Distance between Title and arrow image
+ (float)arrowPadding;



@end
