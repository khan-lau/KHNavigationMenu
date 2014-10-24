//
//  NavigationMenuView.h
//  RWBlurPopoverDemo
//
//  Created by Khan on 14-10-22.
//  Copyright (c) 2014年 Khan.Lau. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MenuButton;

@interface NavigationMenuView : UIView

@property (nonatomic, strong) MenuButton *menuButton;
@property (nonatomic)         BOOL isPopoverViewTransparent;



- (id)initWithFrame:(CGRect)frame title:(NSString *)title;
- (void)displayMenuInVcl:(UIViewController *)parentView  contentVcl:(UIViewController*) contentVcl;

@end
