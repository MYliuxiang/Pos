//
//  TransationModel.h
//  Pos
//
//  Created by 刘翔 on 2021/6/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TransationModel : NSObject
@property(nonatomic,copy)NSString *count;//    数量    integer(int32)
@property(nonatomic,copy)NSString *countMoney;//    金额    number
@property(nonatomic,copy)NSString *name;//   名称    string
@end

NS_ASSUME_NONNULL_END
