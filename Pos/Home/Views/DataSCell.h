//
//  DataSCell.h
//  Pos
//
//  Created by 刘翔 on 2021/6/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataSCell : UITableViewCell
@property (nonatomic, assign, getter = isExpandable) BOOL expandable;
@property (nonatomic, assign, getter = isExpanded) BOOL expanded;
@property (weak, nonatomic) IBOutlet UILabel *lab;

- (void)addIndicatorView;
- (void)removeIndicatorView;
- (BOOL)containsIndicatorView;
- (void)accessoryViewAnimation;

@end

NS_ASSUME_NONNULL_END
