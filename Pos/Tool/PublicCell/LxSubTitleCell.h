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

@end

NS_ASSUME_NONNULL_END
