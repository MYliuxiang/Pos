//
//  ShopItemModel.m
//  Pos
//
//  Created by 刘翔 on 2021/6/29.
//

#import "ShopItemModel.h"

@implementation ShopItemModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"sid":@"id",@"adescription":@"description"};
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"itemImgs":@"NSString"};
}

@end
