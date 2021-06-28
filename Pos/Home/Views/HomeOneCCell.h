//
//  HomeOneCCell.h
//  Pos
//
//  Created by 刘翔 on 2021/6/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeOneCCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;

@property(nonatomic,strong) ShopItemModel *model;
@end

NS_ASSUME_NONNULL_END
