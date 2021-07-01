//
//  TerminalModel.h
//  Pos
//
//  Created by 刘翔 on 2021/7/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TerminalModel : NSObject
@property(nonatomic,assign) NSInteger bindStatus;//    绑定状态 1-绑定 0-未绑定    string
@property(nonatomic,assign) NSInteger cashbackStatus;//    返现状态 1-已返现 0-未返现    string
@property(nonatomic,copy) NSString *deviceId;//    设备主键    integer(int64)
@property(nonatomic,copy) NSString *deviceNo;//    设备编号    string
@property(nonatomic,copy) NSString *modelName;//    型号
@end

NS_ASSUME_NONNULL_END
