//
//  ProfitModel.h
//  Pos
//
//  Created by tenvine on 2021/7/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProfitModel : NSObject
@property(nonatomic,copy)NSArray *children;//    金额    number
@property(nonatomic,copy)NSArray *models;//   名称    string
@property(nonatomic,copy)NSString *total;//   名称    string
@end

@interface Profit : NSObject
@property(nonatomic,copy)NSString *name;//    金额    number
@property(nonatomic,copy)NSString *value;//   收益    string
@property(nonatomic,copy)NSString *month;//   收益    string
@property(nonatomic,copy)NSString *number;//   收益    string


@end

NS_ASSUME_NONNULL_END
