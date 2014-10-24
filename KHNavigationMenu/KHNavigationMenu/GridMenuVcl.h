//
//  GridMenuVcl.h
//  KHNavigationMenu
//
//  Created by Khan on 14-10-24.
//  Copyright (c) 2014年 Khan.Lau. All rights reserved.
//

@import UIKit;


@protocol GridMenuDelegate <NSObject>

-(void) loadMenu;

@end


@interface GridMenuVcl : UIViewController

@property (nonatomic, strong) NSDictionary * data;

@property (nonatomic , weak) id<GridMenuDelegate> delegate;
@property (nonatomic)        CGFloat offsetY;


-(void) reloadDatasouce;
- (void)dismiss;
@end
