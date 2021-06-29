//
//  ProductOneCell.h
//  Pos
//
//  Created by 刘翔 on 2021/6/22.
//

#import <UIKit/UIKit.h>
#import "GHCountField.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductOneCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (nonatomic,strong) GHCountField *field;

@end

NS_ASSUME_NONNULL_END
