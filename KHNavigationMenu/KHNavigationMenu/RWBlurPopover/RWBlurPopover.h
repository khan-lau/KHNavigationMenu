//
//  RWBlurPopover.h
//  RWBlurPopoverDemo
//
//  Created by Zhang Bin on 2014-07-07.
//  Copyright (c) 2014年 Zhang Bin. All rights reserved.
//

@import UIKit;

typedef void(^OnShowStatusCallBack)(BOOL isShow) ;

@interface RWBlurPopover : NSObject




/// set to YES if you want content view controller to be dismissed by "throwing away"
@property (nonatomic, assign, getter = isThrowingGestureEnabled) BOOL throwingGestureEnabled;


@property (nonatomic, copy) OnShowStatusCallBack onShowStatus;
@property (nonatomic)       BOOL isTransparent;  //


/// create a popover with a content view controller
/// size of the popover is determined by [contentViewController preferredContentSize]
- (instancetype)initWithContentViewController:(UIViewController *)contentViewController;

/// shows a popover inside presenting view controller
- (void)showInViewController:(UIViewController *)presentingViewController;

- (void)dismissWithCompletion:(dispatch_block_t)completion ;

/// convenient method
+ (void)showContentViewController:(UIViewController *)contentViewController insideViewController:(UIViewController *)presentingViewController;

@end




