//
//  AdressVC.h
//  Pos
//
//  Created by 刘翔 on 2021/6/27.
//


#import "BaseViewController.h"
#import "AdressModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AdressVC : BaseViewController


@property(nonatomic,copy) void (^selectBlock)(AdressModel *model);

@end

NS_ASSUME_NONNULL_END
