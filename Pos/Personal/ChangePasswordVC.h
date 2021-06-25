//
//  ChangePasswordVC.h
//  Pos
//
//  Created by 李立 on 2021/6/24.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChangePasswordVC : BaseViewController
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UITextField *oldtextifld;
@property (nonatomic,strong) UITextField *newtextifld;
@property (nonatomic,strong) UITextField *conttextifld;

@end

NS_ASSUME_NONNULL_END
