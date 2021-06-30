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

@property (nonatomic, strong) NSMutableArray *dataList;
@end

@implementation PosterSubVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.hidden = YES;
    self.dataList = [NSMutableArray array];
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
    self.collectionView.mj_header = [LxResfreshHeader headerWithRefreshingBlock:^{
        self.pageNum = 1;
        [self loadData];
    }];
    
    self.collectionView.mj_footer = [LxRefreshFooter footerWithRefreshingBlock:^{
        [self loadData];
    }];
    [self.collectionView.mj_header beginRefreshing];
    
}

- (void)loadData{
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_recommendBack_list];
    entity.needCache = NO;
    if (self.model) {
        entity.parameters = @{@"modelId":self.model.did,@"pageNum":@(self.pageNum),@"pageSize":@(PageSize)};
    }
    [BANetManager ba_request_GETWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 200) {
            
            NSArray *models = [PosterModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"rows"]];
            if (self.pageNum == 1) {
                [self.dataList removeAllObjects];
            }
            [self.dataList addObjectsFromArray:models];
            self.pageNum++;
            
            if ([result[@"data"][@"total"] intValue] == self.dataList.count) {
                [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.collectionView.mj_footer endRefreshing];
            }
            [self.collectionView.mj_header endRefreshing];
            [self.collectionView reloadData];
          
        }else{
            
            [self.collectionView.mj_footer endRefreshing];
            [self.collectionView.mj_header endRefreshing];

        }
        
    } failureBlock:^(NSError *error) {
        [self.collectionView.mj_footer endRefreshing];
        [self.collectionView.mj_header endRefreshing];

        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
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
    
    PosterCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PosterCCellID" forIndexPath:indexPath];
    PosterModel *model = self.dataList[indexPath.row];
    [cell.img sd_setImageWithURL:[NSURL URLWithString:model.background]];
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
    if (self.seltedBlock) {
        self.seltedBlock(self.dataList[indexPath.row]);
    }
    
}


#pragma mark - JXCategoryListContentViewDelegate

/**
 实现 <JXCategoryListContentViewDelegate> 协议方法，返回该视图控制器所拥有的「视图」
 */
- (UIView *)listView {
    return self.view;
}




@end
