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

//获取通讯录
extern NSString *const Url_user_contacts;

//业绩
extern NSString *const Url_proxy_tradingResultsMonthMoney;

//面对面开通
extern NSString *const Url_user_faceToFace;

//查询设备型号列表
extern NSString *const Url_model_list;

//获取商户登记数据
extern NSString *const Url_merc_reg;

//获取商户登记数据列表
extern NSString *const Url_merc_reg_list;

//查询代理商直属下级列表
extern NSString *const Url_proxyResults_list;

//查询代理商-日列表数据
extern NSString *const Url_proxyResults_serviceList;

//查询代理商-月列表数据
extern NSString *const Url_proxyResults_serviceListMonth;

//获取app用户信息
extern NSString *const Url_user_userAppInfo;

//获取app用户详细信息
extern NSString *const Url_user_userAppInfoDetail;

//查询推荐背景底图列表
extern NSString *const Url_recommendBack_list;



 
NS_ASSUME_NONNULL_BEGIN

@interface HttpHelp : NSObject

@end

NS_ASSUME_NONNULL_END
