//
//  RWBlurPopoverView.h
//  RWBlurPopoverDemo
//
//  Created by Zhang Bin on 2014-10-16.
//  Copyright (c) 2014年 Zhang Bin. All rights reserved.
//

@import UIKit;

typedef void(^OnShowStatusCallBack)(BOOL isShow) ;

@interface RWBlurPopoverView : UIView

@property (nonatomic)         CGFloat offsetY;  //contentview frame {y}
@property (nonatomic)         BOOL isPopover;




@property (nonatomic, strong) UIView *blurView;
@property (nonatomic, weak) UIView *container;
@property (nonatomic, copy) dispatch_block_t dismissalBlock;
@property (nonatomic, copy) OnShowStatusCallBack onShowStatus;

@property (nonatomic, assign, getter = isThrowingGestureEnabled) BOOL throwingGestureEnabled;

- (instancetype)initWithContentView:(UIView *)contentView contentSize:(CGSize)contentSize;

//- (void)animatePresentation;
- (void)animatePresentationWithCompletion:(void (^)(void))completion;
- (void)animateDismissalWithCompletion:(dispatch_block_t)completion;


- (void) setContainerTransparent:(BOOL) isTransparent;
@end
