//
//  TradeDetailModel.m
//  Pos
//
//  Created by tenvine on 2021/7/2.
//

#import "TradeDetailModel.h"

@implementation TradeDetailModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"tid":@"id"};
}
@end
