//
//  AgentDataModel.h
//  Pos
//
//  Created by tenvine on 2021/6/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AgentDataModel : NSObject


@property(nonatomic,copy)NSString *dayEarnMoney;//    单日总收益额    number
@property(nonatomic,copy)NSString *dayTradMoney;//     单日总交易额    number
@property(nonatomic,copy)NSString *aid;//         integer(int64)
@property(nonatomic,copy)NSString *mercCount;//     商户总数    integer(int32)
@property(nonatomic,copy)NSString *serviceCount;//     服务商总数    integer(int32)
@property(nonatomic,copy)NSString *time;//     时间
@end

NS_ASSUME_NONNULL_END
