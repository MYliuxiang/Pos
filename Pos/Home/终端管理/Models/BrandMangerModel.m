//
//  BrandMangerModel.m
//  Pos
//
//  Created by 刘翔 on 2021/7/1.
//

#import "BrandMangerModel.h"

@implementation BrandMangerModel

@end

@implementation CenterModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"children":@"ChildrenModel"};
}
@end


@implementation ChildrenModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"devices":@"BDeviceModel"};
}
@end

@implementation BDeviceModel

@end


