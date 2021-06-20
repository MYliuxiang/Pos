//
//  TerminalCenterVC.h
//  Pos
//
//  Created by 刘翔 on 2021/6/21.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TerminalCenterVC : BaseViewController<JXPagerViewListViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

NS_ASSUME_NONNULL_END
