//
//  ViewController.m
//  KHNavigationMenu
//
//  Created by Khan on 14-10-24.
//  Copyright (c) 2014年 Khan.Lau. All rights reserved.
//

#import "ViewController.h"
#import "RWBlurPopover.h"
#import "NavigationMenuView.h"
#import "MenuButton.h"

#import "DemoPopGridMenuVcl.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)loadView {
    [super loadView];
    
    UIImageView *imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic.jpg"]];
    imageview.contentMode = UIViewContentModeScaleAspectFill;
    imageview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    imageview.frame = self.view.bounds;
    [self.view addSubview:imageview];
}



//- (void)dismiss {
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Demo";
    
    CGRect frame = CGRectMake(0.0, 0.0, 200.0, self.navigationController.navigationBar.bounds.size.height);
    NavigationMenuView * menu = [[NavigationMenuView alloc] initWithFrame:frame title:@"老子就要弄一个智力超常的大标题"];
//    NavigationMenuView * menu = [[NavigationMenuView alloc] initWithFrame:frame title:@"大标题"];
    menu.menuButton.title.textColor = [UIColor blackColor];
    menu.isPopoverViewTransparent = YES;
    self.navigationItem.titleView = menu;
    
    DemoPopGridMenuVcl *vc = [[DemoPopGridMenuVcl alloc] init];
    [menu displayMenuInVcl:self contentVcl:vc];
}



@end
