//
//  XPTabBar.h
//  JD
//
//  Created by dragon on 16/7/4.
//  Copyright © 2016年 win. All rights reserved.
//  模仿下UITabBar
// UITabBar里面的按钮由UITabBarController的子控制器

#import <UIKit/UIKit.h>

@class XPTabBar;
@protocol XPTabBarDelegate <NSObject>

@optional
- (void)tabBar:(XPTabBar *)tabBar didClickButton:(NSInteger)index;

@end

@interface XPTabBar : UIView
/** 模型数组(UITabBarItem) */
@property (nonatomic, strong) NSArray *items;

/** 代理 */
@property (nonatomic,weak)id<XPTabBarDelegate> delegate;
@end
