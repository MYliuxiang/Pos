//
//  AchDetailSubModel.h
//  Pos
//
//  Created by tenvine on 2021/6/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AchDetailSubModel : NSObject
@property(nonatomic,copy) NSString *time;
@property(nonatomic,copy) NSString *fwcount;
@property(nonatomic,copy) NSString *shcount;
@property(nonatomic,copy) NSString *totalProfit;
@property(nonatomic,copy) NSString *totalTransaction;
@end

NS_ASSUME_NONNULL_END
