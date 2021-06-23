//
//  LxAccessoryCell.h
//  Pos
//
//  Created by 刘翔 on 2021/6/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LxAccessoryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintLeft;

@end

NS_ASSUME_NONNULL_END
