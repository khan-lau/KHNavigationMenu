//
//  RWBlurPopover.m
//  RWBlurPopoverDemo
//
//  Created by Zhang Bin on 2014-07-07.
//  Copyright (c) 2014年 Zhang Bin. All rights reserved.
//

#import <objc/runtime.h>
#import "RWBlurPopover.h"
#import "RWBlurPopoverView.h"


@interface UIViewController (RWBlurPopover)

- (void)RWBlurPopover_dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion;

@property (nonatomic, strong) RWBlurPopover *RWBlurPopover_associatedPopover;

@end



@interface RWBlurPopover () <UIGestureRecognizerDelegate>

@property (nonatomic, weak) UIViewController *contentViewController;
@property (nonatomic, weak) UIViewController *presentingViewController;
@property (nonatomic, strong) RWBlurPopoverView *popoverView;

@end

static void swizzleMethod(Class class, SEL originSelector, SEL swizzledSelector) {
    Method originMethod = class_getInstanceMethod(class, originSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod = class_addMethod(class, originSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    } else {
        method_exchangeImplementations(originMethod, swizzledMethod);
    }
}

@implementation RWBlurPopover
@synthesize onShowStatus;

+ (void)load {
    // use method swizzling to capture content view controller 'dismissViewController' message and 'presentingViewController' message
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        swizzleMethod([UIViewController class], @selector(dismissViewControllerAnimated:completion:), @selector(RWBlurPopover_dismissViewControllerAnimated:completion:));
    });
}

- (instancetype)initWithContentViewController:(UIViewController *)contentViewController {
    self = [super init];
    if (self) {
        self.contentViewController = contentViewController;
        self.contentViewController.view.userInteractionEnabled = YES;
        self.throwingGestureEnabled = YES;
        
        self.contentViewController.RWBlurPopover_associatedPopover = self;
    }
    return self;
}

- (void)setThrowingGestureEnabled:(BOOL)throwingGestureEnabled {
    _throwingGestureEnabled = throwingGestureEnabled;
    [self.popoverView setThrowingGestureEnabled:throwingGestureEnabled];
}

- (void)showInViewController:(UIViewController *)presentingViewController {
    if (presentingViewController.RWBlurPopover_associatedPopover != nil) {
        NSLog(@"failed to present a RWBlurPopover while another popover is presenting. ");
        return;
    }
    
    
    self.presentingViewController = presentingViewController;
    self.presentingViewController.RWBlurPopover_associatedPopover = self;
    
    self.popoverView = [[RWBlurPopoverView alloc] initWithContentView:self.contentViewController.view contentSize:[self.contentViewController preferredContentSize]];
    self.popoverView.offsetY = 0.0f;
    if (self.presentingViewController != nil && self.presentingViewController.edgesForExtendedLayout != UIRectEdgeNone) {
        if ([UIApplication sharedApplication].statusBarHidden == NO) {
            self.popoverView.offsetY += 20.0f;
        }
        if (self.presentingViewController.navigationController != nil) {
            self.popoverView.offsetY += 45.0f;
        }
    }
    
    if ( YES == self.isTransparent ) {
        [self.popoverView setContainerTransparent:YES];
    }
    
    
    self.popoverView.throwingGestureEnabled = self.throwingGestureEnabled;
    self.popoverView.frame = self.presentingViewController.view.bounds;
    self.popoverView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.popoverView.translatesAutoresizingMaskIntoConstraints = YES;
    self.popoverView.throwingGestureEnabled = self.throwingGestureEnabled;
    
//    UITapGestureRecognizer *nothing_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doNothing)];
//    [self.contentViewController.view addGestureRecognizer:nothing_tap];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [self.popoverView.blurView addGestureRecognizer:tapGesture];
    tapGesture.delegate = self;

    [self.presentingViewController addChildViewController:self.contentViewController];
    [self.presentingViewController.view addSubview:self.popoverView];
    [self.contentViewController didMoveToParentViewController:self.presentingViewController];
    
    __weak typeof(self) weakSelf = self;
    self.popoverView.dismissalBlock = ^{
        typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.contentViewController willMoveToParentViewController:nil];
        [strongSelf.popoverView removeFromSuperview];
        [strongSelf.contentViewController removeFromParentViewController];
        
        strongSelf.popoverView = nil;
        strongSelf.contentViewController.RWBlurPopover_associatedPopover = nil;
        strongSelf.presentingViewController.RWBlurPopover_associatedPopover = nil;
        
        if( weakSelf.onShowStatus ){
            weakSelf.onShowStatus(NO);
        }
    };
    
    [self.popoverView animatePresentationWithCompletion:^{
        if( onShowStatus ){
            onShowStatus(YES);
        }
    } ];
    
}

- (void)dismiss {
    [self.popoverView animateDismissalWithCompletion:nil];
}

- (void)dismissWithCompletion:(dispatch_block_t)completion {
    [self.popoverView animateDismissalWithCompletion:completion];
}

+ (void)showContentViewController:(UIViewController *)contentViewController insideViewController:(UIViewController *)presentingViewController {
    RWBlurPopover *popoer = [[RWBlurPopover alloc] initWithContentViewController:contentViewController];
    [popoer showInViewController:presentingViewController];
}



-(void) doNothing{}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    return NO;
//}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    return touch.view == self.popoverView.blurView ? YES : NO;
}

@end





@implementation UIViewController (RWBlurPopover_dismiss)

- (void)RWBlurPopover_dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    UIViewController *presented = self;
    RWBlurPopover *popover = self.RWBlurPopover_associatedPopover;
    while (popover == nil && presented != nil) {
        popover = presented.RWBlurPopover_associatedPopover;
        presented = presented.parentViewController;
    }
    
    if (popover) {
        // this view controller is displayed inside a RWBlurPopover
        // and about to be dismissed
        [popover dismissWithCompletion:completion];
    } else {
        // perform regular dismissal
        [self RWBlurPopover_dismissViewControllerAnimated:flag completion:completion];
    }
}

static const char *RWBlurPopoverKey = "RWBlurPopoverKey";

- (RWBlurPopover *)RWBlurPopover_associatedPopover {
    return objc_getAssociatedObject(self, RWBlurPopoverKey);
}

- (void)setRWBlurPopover_associatedPopover:(RWBlurPopover *)RWBlurPopover_associatedPopover {
    objc_setAssociatedObject(self, RWBlurPopoverKey, RWBlurPopover_associatedPopover, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
