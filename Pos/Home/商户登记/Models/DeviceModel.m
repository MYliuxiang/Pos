//
//  DeviceModel.m
//  Pos
//
//  Created by 刘翔 on 2021/6/30.
//

#import "DeviceModel.h"

@implementation DeviceModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"did":@"id"};
}
@end
