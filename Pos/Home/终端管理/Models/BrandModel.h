//
//  BrandModel.h
//  Pos
//
//  Created by 刘翔 on 2021/6/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BrandModel : NSObject
@property(nonatomic,copy) NSString *brandId;

@property(nonatomic,copy) NSString *brandImg;    //品牌logo图片    string
@property(nonatomic,copy) NSString *brandName;    //品牌名    string
@property(nonatomic,copy) NSString *createTime;    //创建时间    string(date-time)
@property(nonatomic,copy) NSString *descript;    //品牌介绍    string
@property(nonatomic,copy) NSString *firstLetter;   // 检索首字母    string
@property(nonatomic,copy) NSString *sort;    //排序    integer(int64)
@property(nonatomic,copy) NSString *status;    //状态（ 0停用 1启用）    string
@property(nonatomic,copy) NSString *updateTime;    //更新时间

@end

NS_ASSUME_NONNULL_END
