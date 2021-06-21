//
//  TerminalTransfOneVC.h
//  Pos
//
//  Created by tenvine on 2021/6/21.
//

#import "BaseViewController.h"
#import "TransfCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface TerminalTransfOneVC : BaseViewController<JXPagerViewListViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

NS_ASSUME_NONNULL_END
