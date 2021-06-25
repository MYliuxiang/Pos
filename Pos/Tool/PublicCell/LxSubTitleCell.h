//
//  LxSubTitleCell.h
//  Pos
//
//  Created by 刘翔 on 2021/6/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LxSubTitleCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lab1;
@property (weak, nonatomic) IBOutlet UILabel *lab2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftConstrint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightConstrint;


//折叠用的属性
@property (nonatomic, assign, getter = isExpanded) BOOL expanded;
@property (nonatomic, assign, getter = isExpandable) BOOL expandable;

- (void)addIndicatorView;
- (void)removeIndicatorView;
- (BOOL)containsIndicatorView;
- (void)accessoryViewAnimation;
@end

NS_ASSUME_NONNULL_END
