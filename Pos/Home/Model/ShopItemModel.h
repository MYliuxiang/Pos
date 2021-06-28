//
//  ShopItemModel.h
//  Pos
//
//  Created by 刘翔 on 2021/6/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShopItemModel : NSObject


@property(nonatomic,copy) NSString *brandId;//    商品品牌    integer(int64)
@property(nonatomic,copy) NSString *createTime;//    创建时间    string(date-time)
@property(nonatomic,copy) NSString *sid;//        integer(int64)
@property(nonatomic,copy) NSString *indexImg;//    商品首图    string
@property(nonatomic,copy) NSString *introduce;//    商品介绍    string
@property(nonatomic,copy) NSArray *itemImgs;//    商品图片    string
@property(nonatomic,copy) NSString *name;//    商品名称    string
@property(nonatomic,assign) CGFloat price;//    商品价格    number
@property(nonatomic,copy) NSString *status;//    商品状态 0-下架 1-上架    string
@property(nonatomic,copy) NSString *stock;//        integer(int64)
@property(nonatomic,copy) NSString *total;//    商品库存    integer(int64)
@property(nonatomic,copy) NSString *type;//    商品类型 0-非押金 1-押金    string
@property(nonatomic,copy) NSString *updateTime;//    更新时间


@end

NS_ASSUME_NONNULL_END
