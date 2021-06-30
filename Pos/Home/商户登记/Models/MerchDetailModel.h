//
//  MerchDetailModel.h
//  Pos
//
//  Created by 刘翔 on 2021/6/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MerchDetailModel : NSObject

@property(nonatomic,copy) NSString *deviceNo;//    机器编码    string
@property(nonatomic,copy) NSString *mercNo;//    商户识别号    string
@property(nonatomic,copy) NSString *name;//    姓名    string
@property(nonatomic,copy) NSString *phone;//    手机号    string
@property(nonatomic,copy) NSString *registration;//    登记时间    string(date-time)
@property(nonatomic,strong) NSArray *tradingDataList;//    交易数据    array    交易数据
@property(nonatomic,assign) float tradingMoneySum;//    累计交易金额    number
@property(nonatomic,copy) NSString *typeName;//    1小微 2企业 3快速 4个体工商户 5特殊商户    string


@end

@interface TradingModel : NSObject

@property(nonatomic,copy) NSString *endTime;//    结束时间    string(date-time)
@property(nonatomic,copy) NSString *money;//    金额    number
@property(nonatomic,copy) NSString *startTime;//    开始时间
@end


NS_ASSUME_NONNULL_END


