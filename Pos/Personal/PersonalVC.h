//
//  PersonalVC.h
//  Pos
//
//  Created by tenvine on 2021/6/16.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PersonalVC : BaseViewController
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIImageView *headimageview;
@property (nonatomic,strong) UILabel *namelabel;
@property (nonatomic,strong) UILabel *iphonelabel;
@property (nonatomic,strong) UILabel *yaoqingmalabel;

@end

NS_ASSUME_NONNULL_END
