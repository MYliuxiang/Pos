//
//  LoginManger.h
//  BHGY
//
//  Created by liuxiang on 2020/7/16.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface UserPhoto : NSObject

@property (nonatomic,copy)  NSString *createTime;
@property (nonatomic,copy)  NSString *sid;
@property (nonatomic,copy)  NSString *imageId;
@property (nonatomic,copy)  NSString *userId;
@property (nonatomic,assign)  int isItMe;
@property (nonatomic,assign)  int type;

@end


@interface LoginModel : NSObject
@property (nonatomic,copy)  NSString *token;   //token




@end

@interface LoginManger : NSObject
@property(nonatomic,strong) LoginModel *currentLoginModel;

+ (instancetype)sharedManager;
@end

NS_ASSUME_NONNULL_END
