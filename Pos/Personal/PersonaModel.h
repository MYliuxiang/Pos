//
//  PersonaModel.h
//  Pos
//
//  Created by 李立 on 2021/7/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PersonaModel : NSObject
@property (nonatomic,copy) NSString *avatar; //用户头像
@property (nonatomic,copy) NSString *enterpriseCertification; //是否实名 0-未认证 1-已认证
@property (nonatomic,copy) NSString *immediateNumber; //用户直属商户数
@property (nonatomic,copy) NSString *invitationCode; //邀请码
@property (nonatomic,copy) NSString *name; //用户姓名
@property (nonatomic,copy) NSString *parentName; //用户上级名字
@property (nonatomic,copy) NSString *parentPhone; //用户上级手机
@property (nonatomic,copy) NSString *phone; //用户手机
@property (nonatomic,copy) NSString *subordinateNumber; //用户下代理直属商户数
@property (nonatomic,copy) NSString *verified; //是否实名 0-未实名 1-已实名

@end

NS_ASSUME_NONNULL_END
