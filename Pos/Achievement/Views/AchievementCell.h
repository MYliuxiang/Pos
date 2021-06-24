//
//  AchievementCell.h
//  Pos
//
//  Created by tenvine on 2021/6/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AchievementCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *number2L;
@property (weak, nonatomic) IBOutlet UILabel *number1L;
@property (weak, nonatomic) IBOutlet UILabel *number3L;
@property (weak, nonatomic) IBOutlet UILabel *number4L;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;
@property (weak, nonatomic) IBOutlet UIView *view2;

@end

NS_ASSUME_NONNULL_END
