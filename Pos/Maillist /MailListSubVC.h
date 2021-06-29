//
//  MailListSubVC.h
//  Pos
//
//  Created by 刘翔 on 2021/6/27.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MailListSubVC : BaseViewController<JXPagerViewListViewDelegate>
@property(nonatomic,assign) NSInteger type;

@end

NS_ASSUME_NONNULL_END
