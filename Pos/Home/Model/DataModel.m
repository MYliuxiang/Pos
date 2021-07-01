//
//  DataModel.m
//  Pos
//
//  Created by tenvine on 2021/6/18.
//

#import "DataModel.h"

@implementation DataModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"children":@"DataChildrenModel"};
}

@end

@implementation DataChildrenModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"did":@"id"};
}

@end
