//
//  PosterVC.h
//  Pos
//
//  Created by tenvine on 2021/6/22.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PosterVC : BaseViewController

@property(nonatomic,copy)void (^seltedBlock)(PosterModel *model);
@end

NS_ASSUME_NONNULL_END
