//
//  TradeDetailModel.h
//  Pos
//
//  Created by tenvine on 2021/7/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TradeDetailModel : NSObject

@property(nonatomic,copy) NSString *amount;//    交易金额    number
@property(nonatomic,assign) NSInteger cardFlag;//    卡类型 借贷标识 1 借记 2 贷记 3 境外卡 扫码交易为空    string
@property(nonatomic,assign) NSInteger cardType;//    IC卡和磁条卡标识 1 IC卡 2 磁条卡    string
@property(nonatomic,assign) NSInteger cloudFlashPayIdentity;//    云闪付标志 0 不是 1 是    string
@property(nonatomic,copy) NSString *createTime;//    创建时间    string(date-time)
@property(nonatomic,copy) NSString *deviceNo;//    设备号    string
@property(nonatomic,assign) NSInteger dualFreeIdentity;//    双免标识 0 不是 1 是    string
@property(nonatomic,copy) NSString *tid;//    主键    integer(int64)
@property(nonatomic,copy) NSString *mercNo;//    商户号    string
@property(nonatomic,copy) NSString *payBank;//    支付银行    string
@property(nonatomic,copy) NSString *payChannelNo;//    支付通道订单号 微信、支付宝订单号    string
@property(nonatomic,assign) NSInteger payStatus;//    交易状态 1-成功    string
@property(nonatomic,copy) NSString *payTime;//    交易支付时间    string
@property(nonatomic,assign) NSInteger payType;//    支付类型 1.条码支付,2.声波支付,3.二维码支付, 4.线上支付，6.刷脸支付    string
@property(nonatomic,copy) NSString *tradeDate;//    交易日期 yyyyMMdd    string
@property(nonatomic,copy) NSString *tradeNo;//    交易流水号    string
@property(nonatomic,copy) NSString *tradeTime;//    交易时间 HHmmSS    string
@property(nonatomic,copy) NSString *updateTime;//    更新时间    string(date-time)
@property(nonatomic,copy) NSString *userId;//    C端唯一用户标识
@end

NS_ASSUME_NONNULL_END
