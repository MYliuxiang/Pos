//
//  AdressModel.h
//  Pos
//
//  Created by 刘翔 on 2021/6/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AdressModel : NSObject


@property(nonatomic,copy) NSString *addrDetail;//    地址详情    string
@property(nonatomic,copy) NSString *cityName;//    城市名称    string
@property(nonatomic,copy) NSString *createTime;//    创建时间    string(date-time)
@property(nonatomic,assign) BOOL defaultValue;//    是否为默认地址 0-不默认 1-默认    string
@property(nonatomic,copy) NSString *districtCode;//    地区    string
@property(nonatomic,copy) NSString *districtName;//    地区名称    string
@property(nonatomic,copy) NSString *aid;//    主键    integer(int64)
@property(nonatomic,copy) NSString *name;//    收件人名称    string
@property(nonatomic,copy) NSString *phone;//    收件人手机    string
@property(nonatomic,copy) NSString *procName;//    省份名称    string
@property(nonatomic,copy) NSString *proxyId;//    代理id    integer(int64)
@property(nonatomic,copy) NSString *updateTime;//

@end

NS_ASSUME_NONNULL_END
