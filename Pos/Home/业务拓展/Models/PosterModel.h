//
//  PosterModel.h
//  Pos
//
//  Created by tenvine on 2021/6/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PosterModel : NSObject

@property(nonatomic,copy) NSString *background;//    推荐背景图    string
@property(nonatomic,copy) NSString *createTime;//    创建时间    string(date-time)
@property(nonatomic,copy) NSString *pid;//    主键    integer(int64)
@property(nonatomic,copy) NSString *modelId;//        integer(int64)
@property(nonatomic,copy) NSString *name;//    别名    string
@property(nonatomic,copy) NSString *sort;//        integer(int32)
@property(nonatomic,copy) NSString *status;//    状态 0-停用 1-启用    string
@property(nonatomic,copy) NSString *updateTime;//    更新时间
@end

NS_ASSUME_NONNULL_END
