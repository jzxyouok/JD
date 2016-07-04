//
//  XPTabBarController.m
//  JD
//
//  Created by dragon on 16/7/4.
//  Copyright © 2016年 win. All rights reserved.
//

#import "XPTabBarController.h"
#import "XPHomeViewController.h"
#import "XPCategoryViewController.h"
#import "XPDiscoverViewController.h"
#import "XPShoppingCarViewController.h"
#import "XPMineViewController.h"
#import "XPTabBar.h"

@interface XPTabBarController ()<XPTabBarDelegate>
// 保存所有控制器对应按钮的内容（UITabBarItem）
@property (nonatomic, strong) NSMutableArray *items;
@end

@implementation XPTabBarController

- (NSMutableArray *)items
{
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.tabBar.tintColor = [UIColor redColor];
//    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tabBar_bg"]];
    
    // 添加子控制器
    [self addAllChildViewController];

   
    //自定义tabBar
    [self configTabBar];
   
}


#pragma mark - 自定义tabBar
// 移除系统的tabBar，相当于把tabBar上所有的按钮移除
// 把一个控件移除父控件并不会马上销毁，什么时候销毁，一般在下一次运行循环的时候，就会判断这个对象有没有强引用，如果没有，才会销毁。
- (void)configTabBar
{
    [self.tabBar removeFromSuperview];
    XPTabBar *tabBar = [[XPTabBar alloc] init];
    // 存储UITabBarItem
    tabBar.items = self.items;
    
    tabBar.delegate = self;
    
    tabBar.backgroundColor = [UIColor whiteColor];
    
    tabBar.frame = self.tabBar.frame;
    
    [self.view addSubview:tabBar];
}

#pragma mark - XMGTabBarDelegate方法
// 监听tabBar上按钮的点击
- (void)tabBar:(XPTabBar *)tabBar didClickButton:(NSInteger)index
{
    self.selectedIndex = index;
}

#pragma mark - 添加所有子控制器
- (void)addAllChildViewController
{
    XPHomeViewController *home = [XPHomeViewController new];
    [self addOneChildViewController:home image:[UIImage imageNamed:@"tabBar_home_normal"] selImage:[UIImage imageNamed:@"tabBar_home_press"] withTitle:@"首页"];
    
    XPCategoryViewController *cat = [XPCategoryViewController new];
    [self addOneChildViewController:cat image:[UIImage imageNamed:@"tabBar_category_normal"] selImage:[UIImage imageNamed:@"tabBar_category_press"] withTitle:@"分类"];
    
    XPDiscoverViewController *dis = [XPDiscoverViewController new];
    [self addOneChildViewController:dis image:[UIImage imageNamed:@"tabBar_find_normal"] selImage:[UIImage imageNamed:@"tabBar_find_press"] withTitle:@"发现"];
    
    XPShoppingCarViewController *shop =[ XPShoppingCarViewController new];
    [self addOneChildViewController:shop image:[UIImage imageNamed:@"tabBar_cart_normal"] selImage:[UIImage imageNamed:@"tabBar_cart_press"] withTitle:@"购物车"];
    
    XPMineViewController *mine = [XPMineViewController new];
    [self addOneChildViewController:mine image:[UIImage imageNamed:@"tabBar_myJD_normal"] selImage:[UIImage imageNamed:@"tabBar_myJD_press"] withTitle:@"我的"];
}

#pragma mark -添加一个子控制器
- (void)addOneChildViewController:(UIViewController *)vc image:(UIImage *)image selImage:(UIImage *)selImage withTitle:(NSString *)title
{
    vc.navigationItem.title = title;
    
    //描述对应按钮的内容
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selImage;
    
    vc.view.backgroundColor = [self randomColor];
    
    // 记录所有控制器对应按钮的内容
    [self.items addObject:vc.tabBarItem];
    
    // 把控制器包装成导航控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:nav];
}


- (UIColor *)randomColor
{
    
    CGFloat r = arc4random_uniform(256) / 255.0;
    CGFloat g = arc4random_uniform(256) / 255.0;
    CGFloat b = arc4random_uniform(256) / 255.0;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}
@end
