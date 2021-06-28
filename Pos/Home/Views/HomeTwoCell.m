//
//  HomeTwoCell.m
//  Pos
//
//  Created by 刘翔 on 2021/6/18.
//

#import "HomeTwoCell.h"
#import "HomeTwoCCell.h"

@implementation HomeTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self creatCollection];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataList:(NSArray *)dataList
{
    _dataList = dataList;
    [self.collectionView reloadData];
}

- (void)creatCollection
{
    
    self.layout.itemSize = CGSizeMake(238, 108);
    self.layout.minimumLineSpacing = 16;
    self.layout.minimumInteritemSpacing = 16;
    self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.layout.sectionInset = UIEdgeInsetsMake(0, 16, 0, 16);
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"HomeTwoCCell" bundle:nil] forCellWithReuseIdentifier:@"HomeTwoCCellID"];
    
}

#pragma mark - UICollectionViewDelegate
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    HomeTwoCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeTwoCCellID" forIndexPath:indexPath];
    ActivityModel *model = self.dataList[indexPath.row];
    [cell.img sd_setImageWithURL:model.indexUrl];
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
    ActivityModel *model = self.dataList[indexPath.row];
    HWBaseWebViewController *vc = [HWBaseWebViewController new];
    vc.urlString = model.jumpUrl;
    [self.viewController.navigationController pushViewController:vc animated:YES];

    
}


@end
