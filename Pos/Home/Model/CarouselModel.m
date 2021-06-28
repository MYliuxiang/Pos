//
//  CarouselModel.m
//  Pos
//
//  Created by tenvine on 2021/6/28.
//

#import "CarouselModel.h"

@implementation CarouselModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"cid":@"id",@"cdescription":@"description"};
}

@end
