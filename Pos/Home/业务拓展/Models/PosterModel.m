//
//  PosterModel.m
//  Pos
//
//  Created by tenvine on 2021/6/30.
//

#import "PosterModel.h"

@implementation PosterModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"pid":@"id"};
}
@end
