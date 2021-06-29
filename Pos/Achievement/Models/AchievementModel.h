//
//  AchievementModel.h
//  Pos
//
//  Created by 刘翔 on 2021/6/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AchievementModel : NSObject

@property(nonatomic,copy)NSString *personalAddSum;//     个人商新增商户数    integer(int32)
@property(nonatomic,copy)NSString *personalTradingMoney;//     个人商交易额    number
@property(nonatomic,copy)NSString *serviceAddSum;//     服务商新增商户数    integer(int32)
@property(nonatomic,copy)NSString *serviceTradingMoney;//     服务商交易额    number
@property(nonatomic,copy)NSString *time;// 时间    string

@end

NS_ASSUME_NONNULL_END
