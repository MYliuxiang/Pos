//
//  BrandMangerModel.h
//  Pos
//
//  Created by 刘翔 on 2021/7/1.
//

#import <Foundation/Foundation.h>
@class ChildrenModel;
@class CenterModel;
NS_ASSUME_NONNULL_BEGIN

@interface BrandMangerModel : NSObject


@property(nonatomic,strong) CenterModel *binded;//    已绑定    设备终端管理-每一项    设备终端管理-每一项
@property(nonatomic,strong) CenterModel *cashBack;//     已返现    设备终端管理-每一项    设备终端管理-每一项
@property(nonatomic,strong) CenterModel *expired;//     已过期    设备终端管理-每一项    设备终端管理-每一项
@property(nonatomic,strong) CenterModel *noCashBack;//     未返现    设备终端管理-每一项    设备终端管理-每一项
@property(nonatomic,strong) CenterModel *unbound;//     未绑定    设备终端管理-每一项    设备终端管理-每一项
@property(nonatomic,strong) CenterModel *untied;// 已解绑

@end

@interface CenterModel : NSObject
@property(nonatomic,strong) NSArray *children;//
@property(nonatomic,copy) NSString *count;//    数量    integer(int32)
@property(nonatomic,strong) ChildrenModel *myself;//    当前代理

@end

@interface ChildrenModel : NSObject
@property(nonatomic,strong) NSString *devices;//    设备数组    array    设备信息
@property(nonatomic,copy) NSString *proxyName;//   代理商名字
@property(nonatomic,copy) NSString *proxyId;//   代理商名字

@end

@interface BDeviceModel : NSObject

@property(nonatomic,copy) NSString *deviceNo;//    代理商id    integer(int64)
@property(nonatomic,copy) NSString *modelName;//    代理商名字

@end



NS_ASSUME_NONNULL_END
