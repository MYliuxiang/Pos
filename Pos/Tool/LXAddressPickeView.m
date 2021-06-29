//
//  LXAddressPickeView.m
//  Pos
//
//  Created by tenvine on 2021/6/29.
//

#import "LXAddressPickeView.h"

@implementation LXAddressPickeView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSString *mainBundleDirectory=[[NSBundle mainBundle] bundlePath];
        NSString *path=[mainBundleDirectory stringByAppendingPathComponent:@"pca-code.json"];
        NSURL *url=[NSURL fileURLWithPath:path];
        NSData *data = [[NSData alloc] initWithContentsOfURL:url];
        NSArray *addressA = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        self.dataSourceArr = [self getProvinceModelArr:addressA];
    }
    return self;
}

#pragma mark - 获取模型数组
- (NSArray <BRProvinceModel *>*)getProvinceModelArr:(NSArray *)dataSourceArr {
    NSMutableArray *tempArr1 = [NSMutableArray array];
    for (NSDictionary *proviceDic in dataSourceArr) {
        BRProvinceModel *proviceModel = [[BRProvinceModel alloc]init];
        proviceModel.code = [proviceDic objectForKey:@"code"];
        proviceModel.name = [proviceDic objectForKey:@"name"];
        proviceModel.index = [dataSourceArr indexOfObject:proviceDic];
        NSArray *cityList = [proviceDic.allKeys containsObject:@"children"] ? [proviceDic objectForKey:@"children"] : [proviceDic objectForKey:@"children"];
        NSMutableArray *tempArr2 = [NSMutableArray array];
        for (NSDictionary *cityDic in cityList) {
            BRCityModel *cityModel = [[BRCityModel alloc]init];
            cityModel.code = [cityDic objectForKey:@"code"];
            cityModel.name = [cityDic objectForKey:@"name"];
            cityModel.index = [cityList indexOfObject:cityDic];
            NSArray *areaList = [cityDic.allKeys containsObject:@"children"] ? [cityDic objectForKey:@"children"] : [cityDic objectForKey:@"children"];
            NSMutableArray *tempArr3 = [NSMutableArray array];
            for (NSDictionary *areaDic in areaList) {
                BRAreaModel *areaModel = [[BRAreaModel alloc]init];
                areaModel.code = [areaDic objectForKey:@"code"];
                areaModel.name = [areaDic objectForKey:@"name"];
                areaModel.index = [areaList indexOfObject:areaDic];
                [tempArr3 addObject:areaModel];
            }
            cityModel.arealist = [tempArr3 copy];
            [tempArr2 addObject:cityModel];
        }
        proviceModel.citylist = [tempArr2 copy];
        [tempArr1 addObject:proviceModel];
    }
    return [tempArr1 copy];
}





@end
