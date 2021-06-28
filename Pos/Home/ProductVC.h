//
//  ProductVC.h
//  Pos
//
//  Created by 刘翔 on 2021/6/21.
//

#import "BaseViewController.h"
#import "ProductCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductVC : BaseViewController
@property (nonatomic, strong) ShopItemModel *model;
@end

NS_ASSUME_NONNULL_END
