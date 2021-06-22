//
//  UIViewController+YKViewControllerBarHeight.m
//  PetFamilyHouse
//
//  Created by 致晟文化 on 2019/3/29.
//  Copyright © 2019 致晟文化. All rights reserved.
//

#import "UIViewController+YKViewControllerBarHeight.h"

@implementation UIViewController (YKViewControllerBarHeight)


/**  状态栏的高度 例如没有刘海手机是20 */
-(float)ykStatusbarHeight
{
    return [[UIApplication sharedApplication] statusBarFrame].size.height;
}

/**  导航栏高度+状态栏高度 */
-(float)ykNavigationbarAndTopHeight
{
    return self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height;
}

/** Tabbar高度 */
-(float)ykTabbarHeight
{
    return self.tabBarController.tabBar.bounds.size.height;
}

/** 状态栏 + 导航栏 +底部tabbar */
- (float)ykTopAndNavbarAndTabbarHeight
{
    return self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height + self.tabBarController.tabBar.bounds.size.height;
}


@end
