//
//  TradeDSubCell.h
//  Pos
//
//  Created by 刘翔 on 2021/6/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TradeDSubCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UILabel *cardL;
@property (weak, nonatomic) IBOutlet UILabel *moneyL;

@end

NS_ASSUME_NONNULL_END
