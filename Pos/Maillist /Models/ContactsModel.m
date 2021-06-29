//
//  ContactsModel.m
//  Pos
//
//  Created by 刘翔 on 2021/6/29.
//

#import "ContactsModel.h"

@implementation ContactsModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"cid":@"id"};
}
@end
