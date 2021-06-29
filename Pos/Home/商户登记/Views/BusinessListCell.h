//
//  BusinessListCell.h
//  Pos
//
//  Created by 刘翔 on 2021/6/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BusinessListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *phoneL;
@property (weak, nonatomic) IBOutlet UILabel *numberL;


@property(nonatomic,strong)MerchantModel *model;
@end

NS_ASSUME_NONNULL_END
