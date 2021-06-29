//
//  MailListCell.h
//  Pos
//
//  Created by 刘翔 on 2021/6/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MailListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *userNumL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UILabel *phoneL;

@property(nonatomic,strong) ContactsModel *model;
@end

NS_ASSUME_NONNULL_END
