//
//  StudyListModel.h
//  Pos
//
//  Created by tenvine on 2021/6/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface StudyListModel : NSObject

@property(nonatomic,copy)NSString *createTime;//    创建时间    string(date-time)
@property(nonatomic,copy)NSString *sid;//     主键    integer(int64)
@property(nonatomic,copy)NSString *indexUrl;//    首页图片    string
@property(nonatomic,copy)NSString *subTitle;//    子标题    string
@property(nonatomic,copy)NSString *title;//     标题    string
@property(nonatomic,assign)int type;//
@end

NS_ASSUME_NONNULL_END
