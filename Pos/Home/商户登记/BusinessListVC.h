//
//  BusinessListVC.h
//  Pos
//
//  Created by 刘翔 on 2021/6/23.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BusinessListVC : BaseViewController
@property(nonatomic,copy) NSString *type;
@property(nonatomic,strong) DeviceModel *model;

@end

NS_ASSUME_NONNULL_END
