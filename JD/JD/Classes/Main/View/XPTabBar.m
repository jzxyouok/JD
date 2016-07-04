//
//  XPTabBar.m
//  JD
//
//  Created by dragon on 16/7/4.
//  Copyright © 2016年 win. All rights reserved.
//

#import "XPTabBar.h"
#import "XPTabBarButton.h"
#import "UIView+Frame.h"
// 我们自己的tabBar的按钮也需要模型，UITabBar上的按钮交给UITabBarItem

@interface XPTabBar ()

/** selButton */
@property (nonatomic, strong) XPTabBarButton *selButton;
@end

@implementation XPTabBar

- (void)setItems:(NSArray *)items
{
    _items = items;
    // UITabBarItem保存按钮上的图片
    for (UITabBarItem *item in items) {
        UIButton *btn = [XPTabBarButton buttonWithType:UIButtonTypeCustom];
        btn.tag = self.subviews.count;
        
        [btn setBackgroundImage:item.image forState:UIControlStateNormal];
        
        [btn setBackgroundImage:item.selectedImage forState:UIControlStateSelected];
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        
        [self addSubview:btn];
        
        if (self.subviews.count == 1) {
            //默认选中第一个
            [self btnClick:(XPTabBarButton *)btn];
        }
    }
}

- (void)btnClick:(XPTabBarButton *)button
{
    _selButton.selected = NO;
    button.selected = YES;
    
    _selButton = button;
    
    // 通知tabBarVc切换控制器
    if ([_delegate respondsToSelector:@selector(tabBar:didClickButton:)]) {
        [_delegate tabBar:self didClickButton:button.tag];
    }

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger count = self.subviews.count;
    
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = [UIScreen mainScreen].bounds.size.width / count;
    
    CGFloat h = self.height;
    
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i];
        
        x = i * w;
        
        btn.frame = CGRectMake(x, y, w, h);
    }
}

@end
