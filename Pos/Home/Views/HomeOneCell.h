//
//  HomeOneCell.h
//  Pos
//
//  Created by 刘翔 on 2021/6/18.
//

#import <UIKit/UIKit.h>
#import "ProductVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeOneCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
@property(nonatomic,copy) NSArray *dataList;

@end

NS_ASSUME_NONNULL_END
