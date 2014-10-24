//
//  StructMenuItem.m
//  CIM4Iphone
//
//  Created by Khan on 14-10-23.
//  Copyright (c) 2014年 Khan.Lau. All rights reserved.
//

#import "StructMenuItem.h"

@implementation StructMenuItem

- (id)initWithIconName:(NSString *)icon_name withContent:(NSString *)text isBorder:(BOOL) isborder{
    self = [super init];
    if (self) {
        _iconName = icon_name;
        _content = text;
        _sector = nil;
        _event_target = nil;
        _isBorder = isborder;
    }
    
    return self;
}

- (id)initWithIconName:(NSString *)icon_name withContent:(NSString *)text {
    self = [super init];
    if (self) {
        _iconName = icon_name;
        _content = text;
        _sector = nil;
        _event_target = nil;
        _isBorder = NO;
    }
    
    return self;
}

- (void) addTarget:(id) target action:(SEL)action {
    self.event_target = target;
    self.sector = action;
}

@end //end of StructItem
