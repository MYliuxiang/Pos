//
//  DataModel.m
//  Pos
//
//  Created by tenvine on 2021/6/18.
//

#import "DataModel.h"

@implementation DataModel
/**
 判断是否能够展开, 当subs中有数据时才能展开
 */
- (BOOL)isCanUnfold
{
    return self.subs.count > 0;
}

@end
