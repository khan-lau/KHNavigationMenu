//
//  DemoPopGridMenuVcl.m
//  KHNavigationMenu
//
//  Created by Khan on 14-10-24.
//  Copyright (c) 2014年 Khan.Lau. All rights reserved.
//

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
