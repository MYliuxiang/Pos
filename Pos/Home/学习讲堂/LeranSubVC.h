//
//  LeranSubVC.h
//  Pos
//
//  Created by 刘翔 on 2021/6/23.
//

#import "BaseViewController.h"
#import "LearnTwoCell.h"
#import "LeranOneCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface LeranSubVC : BaseViewController<JXCategoryListContentViewDelegate>

@property(nonatomic,assign) int type;
@end

NS_ASSUME_NONNULL_END
