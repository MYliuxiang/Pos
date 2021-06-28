//
//  ActivityModel.h
//  Pos
//
//  Created by 刘翔 on 2021/6/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ActivityModel : NSObject

@property(nonatomic,copy) NSString *content;
@property(nonatomic,copy) NSString *createTime;
@property(nonatomic,copy) NSString *adescription;
@property(nonatomic,copy) NSString *endTime;
@property(nonatomic,copy) NSString *aid;
@property(nonatomic,copy) NSString *indexUrl;
@property(nonatomic,copy) NSString *jumpUrl;
@property(nonatomic,copy) NSString *startTime;
@property(nonatomic,copy) NSString *status ;
@property(nonatomic,copy) NSString *title ;
@property(nonatomic,copy) NSString *updateTime;
@end

NS_ASSUME_NONNULL_END
