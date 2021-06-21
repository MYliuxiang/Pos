//
//  HomeOneCell.m
//  Pos
//
//  Created by 刘翔 on 2021/6/18.
//

#import "HomeOneCell.h"
#import "HomeOneCCell.h"

@implementation HomeOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self creatCollection];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)creatCollection
{
    
    self.layout.itemSize = CGSizeMake(116, 163);
    self.layout.minimumLineSpacing = 6;
    self.layout.minimumInteritemSpacing = 6;
    self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.layout.sectionInset = UIEdgeInsetsMake(0, 18, 0, 18);
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"HomeOneCCell" bundle:nil] forCellWithReuseIdentifier:@"HomeOneCCellID"];
    
}

#pragma mark - UICollectionViewDelegate
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    HomeOneCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeOneCCellID" forIndexPath:indexPath];
    return cell;
    
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    if ([kind isEqualToString: UICollectionElementKindSectionHeader]){
        UIView *view = [UIView new];
        reusableview = view;
    }
    return reusableview;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProductVC *vc = [ProductVC new];
    [self.viewController.navigationController pushViewController:vc animated:YES];
    
    
}


@end
