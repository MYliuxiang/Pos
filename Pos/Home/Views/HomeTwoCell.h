//
//  HomeTwoCell.h
//  Pos
//
//  Created by 刘翔 on 2021/6/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeTwoCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;

@property(nonatomic,strong) NSArray *dataList;

@end

NS_ASSUME_NONNULL_END
