//
//  AchDetailSubVC.h
//  Pos
//
//  Created by tenvine on 2021/6/24.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AchDetailSubVC : BaseViewController<JXCategoryListContentViewDelegate>
@property (nonatomic,strong) NSMutableArray *agents;
@property (nonatomic,assign) NSInteger type;

@end

NS_ASSUME_NONNULL_END
