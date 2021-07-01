//
//  LLUrl.h
//  BHGY
//
//  Created by liuxiang on 2020/7/16.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

//注册
extern NSString *const Url_register;

//获取APP用户信息
extern NSString *const Url_userAppInfo;

//修改密码
extern NSString *const Url_resetPwd;

//更换手机 - 通过原手机进行更换
extern NSString *const Url_changeiphone2;

//更换手机 - 给新手机发验证码
extern NSString *const Url_changesmsnew;




NS_ASSUME_NONNULL_BEGIN
@interface LLUrl : NSObject

@end

NS_ASSUME_NONNULL_END
