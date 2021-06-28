//
//  ActivityModel.m
//  Pos
//
//  Created by 刘翔 on 2021/6/28.
//

#import "ActivityModel.h"

@implementation ActivityModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"aid":@"id",@"adescription":@"description"};
}

@end
