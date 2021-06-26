//
//  AdressVC.h
//  Pos
//
//  Created by 刘翔 on 2021/6/27.
//

typedef NS_ENUM(NSUInteger, AdressType)
{
    //地址管理
    AdressTypeMange           = 0,
    /*! 地址选择 */
    AdressTypeSelted,
    
};

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AdressVC : BaseViewController

@property(nonatomic,assign) AdressType type;

@end

NS_ASSUME_NONNULL_END
