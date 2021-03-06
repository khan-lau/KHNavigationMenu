KHNavigationMenu
================

NavigationMenu &amp; Popover

#Version 1.0.1
support Xcode 6, ios 7.0+

Test in: iOS 7.0.3, iOS 7.1, iOS 8.0

Support costom pop viewcontroller


英文书写能力一般, 所以用中文描述一下:
1. 开发环境为Xcode6  这个组件支持ios7以上版本

2. 本组件库暂时不支持cocoapods

3. 组件中提供了一个gridmenu的基类, 直接继承可以实现范例图片中效果, 图标尺寸写死了39*39, 但是同时也支持自定义任何形式的UIViewController.

4. 本组件源码使用apache2开源协议, 图片资源不包括在列, 所以禁止在任何商业与非商业程序中使用. 

5. 谢谢 sign, 萨格拉斯 码农 小蔡在开发过程中给予的帮助



# Change Log

v1.0.1 

1. 修复 presentingViewController 为nil 或 presentingViewController.edgesForExtendedLayout != UIRectEdgeNone 状况导致的异常

2. 提高 GridMenuVcl selectedBackgroundView的渲染效率



#demo pic
![file-list](https://github.com/khan-lau/KHNavigationMenu/blob/master/resource/demo.gif)


#example:
##step 1 - define menulist


```objc
// DemoPopGridMenuVcl.h
#import "GridMenuVcl.h"

@interface DemoPopGridMenuVcl : GridMenuVcl

@end


///////////////////////////////////

// DemoPopGridMenuVcl.m

#import "DemoPopGridMenuVcl.h"
#import "StructMenuItem.h"

@interface DemoPopGridMenuVcl () <GridMenuDelegate>

@end

@implementation DemoPopGridMenuVcl


- (void)viewDidLoad {
//    init parent class member object
    self.delegate = self;
    self.offsetY = 40;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGSize)preferredContentSize {
    return CGSizeMake([[UIScreen mainScreen] bounds].size.width , 200);
}



#pragma mark --GridMenuDelegate
- (void) loadMenu {
    StructMenuItem *item1 = [[StructMenuItem alloc] initWithIconName:@"GroupInfo" withContent:NSLocalizedString(@"Info", nil) ];
    [item1 addTarget:self action: @selector(doInfo)];
    StructMenuItem *item2 = [[StructMenuItem alloc] initWithIconName:@"GroupMember" withContent:NSLocalizedString(@"Member", nil) ];
    [item2 addTarget:self action: @selector(doMember)];
    StructMenuItem *item3 = [[StructMenuItem alloc] initWithIconName:@"GroupInvate" withContent:NSLocalizedString(@"Invite", nil) ];
    [item3 addTarget:self action:@selector(doInvite)];
    StructMenuItem *item4 = [[StructMenuItem alloc] initWithIconName:@"GroupSetting" withContent:NSLocalizedString(@"Setting", nil) ];
    [item4 addTarget:self action:@selector(doSetting)];
    StructMenuItem *item5 = [[StructMenuItem alloc] initWithIconName:@"GroupLeave" withContent:NSLocalizedString(@"Leave", nil) ];
    [item5 addTarget:self action:@selector(doLeave)];
    
    NSArray *c = @[ item1, item2, item3, item4, item5 ];
    self.data = @{@"c":c};
}



#pragma mark - action
-(IBAction)doInfo{
    NSLog(@"%s", __FUNCTION__);
    [self dismiss];
}

-(IBAction)doMember{
    NSLog(@"%s", __FUNCTION__);
    [self dismiss];
}

-(IBAction)doInvite{
    NSLog(@"%s", __FUNCTION__);
    [self dismiss];
}

-(IBAction)doSetting{
    NSLog(@"%s", __FUNCTION__);
    [self dismiss];
}

-(IBAction)doLeave{
    NSLog(@"%s", __FUNCTION__);
    [self dismiss];
}

@end
```

##step 2 - setup navigation menubar


```objc
//ViewController.m

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
```





