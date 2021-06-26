//
//  AdressCell.h
//  Pos
//
//  Created by 刘翔 on 2021/6/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AdressCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *phoneL;
@property (weak, nonatomic) IBOutlet UILabel *adressL;
@property (weak, nonatomic) IBOutlet UIButton *defaultB;
@property (weak, nonatomic) IBOutlet UIButton *editB;
@property (weak, nonatomic) IBOutlet UIButton *deletedB;
@property (strong, nonatomic) AdressModel *model;

@end

NS_ASSUME_NONNULL_END
