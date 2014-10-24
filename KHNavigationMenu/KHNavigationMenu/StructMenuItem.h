//
//  StructMenuItem.h
//  CIM4Iphone
//
//  Created by Khan on 14-10-23.
//  Copyright (c) 2014年 Khan.Lau. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StructMenuItem : NSObject{
    
}

@property (nonatomic, strong) NSString * iconName;
@property (nonatomic, strong) NSString * content;
@property (nonatomic) id event_target;
@property (nonatomic) SEL sector;
@property (nonatomic) BOOL isBorder;

- (id)initWithIconName:(NSString *)icon_name withContent:(NSString *)text ;
- (id)initWithIconName:(NSString *)icon_name withContent:(NSString *)text isBorder:(BOOL) isborder;
- (void) addTarget:(id) target action:(SEL)action ;

@end //StructItem

