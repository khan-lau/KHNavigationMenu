KHNavigationMenu
================

NavigationMenu &amp; Popover

#demo pic
![file-list](https://github.com/khan-lau/KHNavigationMenu/blob/master/resource/demo.gif)


example:
#step 1 - define menulist


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
//    init parent Class
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

#step 2 - setup navigation menubar

##ViewController.m
```objc
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






