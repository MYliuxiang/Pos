//
//  ContactsModel.h
//  Pos
//
//  Created by 刘翔 on 2021/6/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ContactsModel : NSObject

@property(nonatomic,copy) NSString *createTime;


@property(nonatomic,copy) NSString *amount;
@property(nonatomic,copy) NSString *cid;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *phone;
@property(nonatomic,copy) NSString *registerTime;
@property(nonatomic,assign) NSInteger userNum;

@end

NS_ASSUME_NONNULL_END
