//
//  PosterSubVC.m
//  Pos
//
//  Created by tenvine on 2021/6/22.
//

#import "PosterSubVC.h"

@interface PosterSubVC ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;

@end

@implementation PosterSubVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.hidden = YES;
    [self creatCollection];
}

- (void)creatCollection
{
    
    self.layout.itemSize = CGSizeMake((kScreenWidth - 30) / 2, (kScreenWidth - 30) / 2 / 200 * 268);
    self.layout.minimumLineSpacing = 10;
    self.layout.minimumInteritemSpacing = 10;
    self.layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"PosterCCell" bundle:nil] forCellWithReuseIdentifier:@"PosterCCellID"];
    
}

#pragma mark - UICollectionViewDelegate
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 30;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    PosterCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PosterCCellID" forIndexPath:indexPath];
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
    
    
}


#pragma mark - JXCategoryListContentViewDelegate

/**
 实现 <JXCategoryListContentViewDelegate> 协议方法，返回该视图控制器所拥有的「视图」
 */
- (UIView *)listView {
    return self.view;
}




@end
