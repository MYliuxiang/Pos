//
//  UIViewController+YKViewControllerBarHeight.h
//  PetFamilyHouse
//
//  Created by 致晟文化 on 2019/3/29.
//  Copyright © 2019 致晟文化. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (YKViewControllerBarHeight)


/**  状态栏的高度 例如没有刘海手机是20 */
-(float)ykStatusbarHeight;

/**  导航栏高度+状态栏高度 */
-(float)ykNavigationbarAndTopHeight;

/** Tabbar高度 */
-(float)ykTabbarHeight;

/** 状态栏 + 导航栏 +底部tabbar */
- (float)ykTopAndNavbarAndTabbarHeight;

@end

NS_ASSUME_NONNULL_END
