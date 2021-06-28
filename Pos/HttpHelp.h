//
//  HttpHelp.h
//  WaiHui
//
//  Created by liuxiang on 2018/12/24.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import <Foundation/Foundation.h>


//通知
extern NSString *const HomeLoadNotice;

//发送验证码
extern NSString *const Url_register_sendSmsCode;

//注册
extern NSString *const Url_user_register;

//登录
extern NSString *const Url_user_login;

//首页轮播图
extern NSString *const Url_carousel_list;

//首页活动
extern NSString *const Url_activity_list;

//查询品牌信息列表
extern NSString *const Url_shopBrand_list;

//查询商品列表
extern NSString *const Url_shopItem_list;

//获取商户首页数据
extern NSString *const Url_merc_index;



 
NS_ASSUME_NONNULL_BEGIN

@interface HttpHelp : NSObject

@end

NS_ASSUME_NONNULL_END
