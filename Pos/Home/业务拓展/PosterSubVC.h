//
//  PosterSubVC.h
//  Pos
//
//  Created by tenvine on 2021/6/22.
//

#import "BaseViewController.h"
#import "PosterCCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface PosterSubVC : BaseViewController<JXCategoryListContentViewDelegate>
@property(nonatomic,strong) DeviceModel *model;
@property(nonatomic,copy)void (^seltedBlock)(PosterModel *model);

@end

NS_ASSUME_NONNULL_END
