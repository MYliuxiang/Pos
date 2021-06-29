//
//  DeviceModel.h
//  Pos
//
//  Created by 刘翔 on 2021/6/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeviceModel : NSObject


@property(nonatomic,copy) NSString *code;//    型号编码    string
@property(nonatomic,copy) NSString *createTime;//     创建时间    string(date-time)
@property(nonatomic,copy) NSString *expireDays;//     该型号设备过期时间（默认180天）    integer(int64)
@property(nonatomic,copy) NSString *did;//     主键    integer(int64)
@property(nonatomic,copy) NSString *img;//     图片地址    string
@property(nonatomic,copy) NSString *name;//     型号名    string
@property(nonatomic,copy) NSString *recruitMoney;//     招募奖    number
@property(nonatomic,copy) NSString *updateTime;//     更新时间
@end

NS_ASSUME_NONNULL_END
