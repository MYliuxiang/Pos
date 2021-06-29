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


//前端h5链接

//注册页
extern NSString *const H5_register;
//登录页
extern NSString *const H5_Login;
//学习课堂详情
extern NSString *const H5_StudyDetai;
//活动详情
extern NSString *const H5_ActiveDetal;
//商品详情图文
extern NSString *const H5_GoodsHtml;





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

//获取收货地址列表
extern NSString *const Url_address;

//获取默认收货地址
extern NSString *const Url_address_default;

//创建订单
extern NSString *const Url_shop_createOrder;

//查询学习课堂列表
extern NSString *const Url_study_list;






 
NS_ASSUME_NONNULL_BEGIN

@interface HttpHelp : NSObject

@end

NS_ASSUME_NONNULL_END
