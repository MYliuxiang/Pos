//
//  TerminalSDetailVC.h
//  Pos
//
//  Created by tenvine on 2021/6/24.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@class SettingModel;
@interface TerminalSDetailVC : BaseViewController
@property(nonatomic,strong) TerminalModel *model;
@end

@interface SettingModel : NSObject
@property(nonatomic,copy) NSString *money;
@property(nonatomic,copy) NSString *standard;

@end

NS_ASSUME_NONNULL_END
