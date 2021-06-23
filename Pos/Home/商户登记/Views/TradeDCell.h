//
//  TradeDCell.h
//  Pos
//
//  Created by 刘翔 on 2021/6/23.
//

#import <UIKit/UIKit.h>
#import "WSTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface TradeDCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UIImageView *arrowI;
@property (nonatomic, assign, getter = isExpandable) BOOL expandable;
@property (nonatomic, assign, getter = isExpanded) BOOL expanded;

- (void)addIndicatorView;
- (void)removeIndicatorView;
- (BOOL)containsIndicatorView;
- (void)accessoryViewAnimation;


@end

NS_ASSUME_NONNULL_END
