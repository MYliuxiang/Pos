//
//  AgentDataModel.m
//  Pos
//
//  Created by tenvine on 2021/6/30.
//

#import "AgentDataModel.h"

@implementation AgentDataModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"aid":@"id"};
}
@end
