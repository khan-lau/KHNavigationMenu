//
//  NavigationMenuView.m
//  RWBlurPopoverDemo
//
//  Created by Khan on 14-10-22.
//  Copyright (c) 2014年 Khan.Lau. All rights reserved.
//

#import "NavigationMenuView.h"
#import "MenuButton.h"
#import "MenuConfiguration.h"
#import "RWBlurPopover.h"


@interface NavigationMenuView  ()


@property (nonatomic, strong) UIViewController *menuContainerVcl;
@property (nonatomic, strong) UIViewController* contentVcl;
@property (nonatomic, strong) RWBlurPopover *popoer;

@end


@implementation NavigationMenuView

- (id)initWithFrame:(CGRect)frame title:(NSString *)title {
    self = [super initWithFrame:frame];
    if (self) {
        frame.origin.y += 1.0;
        self.menuButton = [[MenuButton alloc] initWithFrame:frame];
        self.menuButton.title.text = title;
        [self.menuButton addTarget:self action:@selector(onHandleMenuTap:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.menuButton];
    }
    return self;
}


- (void)displayMenuInVcl:(UIViewController *)parentView  contentVcl:(UIViewController*) contentVcl{
    self.menuContainerVcl = parentView;
    self.contentVcl = contentVcl;

    self.popoer = [[RWBlurPopover alloc] initWithContentViewController:self.contentVcl];
    
    __weak __typeof(self) weakSelf = self;
    self.popoer.onShowStatus = ^(BOOL isShow){
        if (isShow) {
            [weakSelf rotateArrow:M_PI];
            weakSelf.menuButton.isActive = YES;
        } else {
            [weakSelf rotateArrow:0];
            weakSelf.menuButton.isActive = NO;
        }
    };
}




#pragma mark -
#pragma mark Actions
- (void)onHandleMenuTap:(id)sender {
    if (self.menuButton.isActive) {
        NSLog(@"On show");
        [self onShowMenu];
    } else {
        NSLog(@"On hide");
        [self onHideMenu];
    }
}

- (void)onShowMenu {
    [self rotateArrow:M_PI];
    if (self.isPopoverViewTransparent) {
        self.popoer.isTransparent = YES;
    } else {
        self.popoer.isTransparent = NO;
    }
    [self.popoer showInViewController:self.menuContainerVcl ];
//    [RWBlurPopover showContentViewController:self.contentVcl insideViewController:self.menuContainerVcl];
}

- (void)onHideMenu {
    [self rotateArrow:0];


    [self.popoer dismissWithCompletion:^{
        
    }];
}

- (void)rotateArrow:(float)degrees {
    [UIView animateWithDuration:[MenuConfiguration animationDuration] delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.menuButton.arrow.layer.transform = CATransform3DMakeRotation(degrees, 0, 0, 1);
    } completion:NULL];
}



#pragma mark -
#pragma mark Memory management
- (void)dealloc {
    self.menuButton = nil;
    self.menuContainerVcl = nil;
}


@end
