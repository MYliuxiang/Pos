//
//  OSSClientHelp.m
//  Pos
//
//  Created by tenvine on 2021/7/2.
//

#import "OSSClientHelp.h"

@implementation OSSClientHelp
+ (instancetype)instance {
    static gzhPhotoManager * shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[OSSClientHelp alloc]init];
    });
    return shareInstance;
}


@end
