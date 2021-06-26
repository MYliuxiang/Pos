//
//  AddAdressVC.h
//  Pos
//
//  Created by 刘翔 on 2021/6/27.
//

#import "BaseViewController.h"
#import "AdressModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddAdressVC : BaseViewController

@property (nonatomic,strong) AdressModel *model;

@property (nonatomic,copy) void (^addBlock)(AdressModel *model) ;


@end

NS_ASSUME_NONNULL_END
