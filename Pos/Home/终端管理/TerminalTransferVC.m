//
//  TerminalTransferVC.m
//  Pos
//
//  Created by tenvine on 2021/6/21.
//

#import "TerminalTransferVC.h"
#import "TransfCell.h"
#import "TerminalTransfOneVC.h"
#import "TerminalTransfTwoVC.h"
#import "TransferRecordVC.h"

@interface TerminalTransferVC ()<JXPagerViewDelegate, JXPagerMainTableViewGestureDelegate>
@property (nonatomic, strong) JXPagerListRefreshView *pagerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *sectionView;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;

@property (nonatomic,assign) int seletedIndex;

@property (nonatomic,copy) NSArray *brandList;


@end

@implementation TerminalTransferVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.title = @"终端划拨";
    self.rightTitle = @"调拨记录";
    self.rightColor = [UIColor colorWithHexString:@"#A2A2A2"];
    [self creatCollection];
    
    _pagerView = [self preferredPagingView];
    self.pagerView.mainTableView.gestureDelegate = self;
    self.pagerView.mainTableView.backgroundColor = [UIColor clearColor];
    self.pagerView.isListHorizontalScrollEnabled = NO;
    [self.view addSubview:self.pagerView];
    [self.pagerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(Height_NavBar);
            make.bottom.right.left.equalTo(self.view);
    }];
    
//    [self.pagerView.listContainerView.scrollView.panGestureRecognizer requireGestureRecognizerToFail:self.navigationController.fd_fullscreenPopGestureRecognizer];
    
    [self setUI];
    [self handerHeadrBWithIndex:0];
    [self loadData];
      
}

- (void)loadData{
    
    dispatch_group_t dispatchGroup = dispatch_group_create();
    dispatch_group_enter(dispatchGroup);

   
    BADataEntity *entity1 = [BADataEntity new];
    entity1.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_shopBrand_list];
    entity1.needCache = NO;
    [MBProgressHUD showHUDAddedTo:lxMbProgressView animated:YES];
    [BANetManager ba_request_GETWithEntity:entity1 successBlock:^(id response) {
           NSDictionary *result = response;
        self.brandList = [BrandModel mj_objectArrayWithKeyValuesArray:result[@"data"]];
        [self.collectionView reloadData];
        [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];

        dispatch_group_leave(dispatchGroup);


        } failureBlock:^(NSError *error) {
            dispatch_group_leave(dispatchGroup);

        } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {

        }];
    
    dispatch_group_notify(dispatchGroup, dispatch_get_main_queue(), ^(){

        NSLog(@"请求完成");
        [self.tableView.mj_header endRefreshing];

    });

    
}

- (void)doRightNavBarRightBtnAction{
    TransferRecordVC *vc = [TransferRecordVC new];
    [self.navigationController pushViewController:vc animated:YES];
}




- (void)setUI{
    self.btn1.layer.cornerRadius = 17.5;
    self.btn1.layer.masksToBounds = YES;
    
    self.btn2.layer.cornerRadius = 17.5;
    self.btn2.layer.masksToBounds = YES;
    
  
}


- (void)handerHeadrBWithIndex:(int)index{
    self.seletedIndex = index;
    if (index == 0) {
        self.btn1.backgroundColor = [UIColor colorWithHexString:@"#FF8901"];
        [self.btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.btn2.backgroundColor = [UIColor whiteColor];
        [self.btn2 setTitleColor:[UIColor colorWithHexString:@"#FF8901"] forState:UIControlStateNormal];
    }else{
        self.btn2.backgroundColor = [UIColor colorWithHexString:@"#FF8901"];
        [self.btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.btn1.backgroundColor = [UIColor whiteColor];
        [self.btn1 setTitleColor:[UIColor colorWithHexString:@"#FF8901"] forState:UIControlStateNormal];
    }
}

- (void)creatCollection
{
    
    self.layout.itemSize = CGSizeMake(75, 110);
    self.layout.minimumLineSpacing = 12;
    self.layout.minimumInteritemSpacing = 12;
    self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.layout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20);
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"TransfCCell" bundle:nil] forCellWithReuseIdentifier:@"TransfCCellID"];
    
}

#pragma mark - UICollectionViewDelegate
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.brandList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    TransfCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TransfCCellID" forIndexPath:indexPath];
    cell.model = self.brandList[indexPath.row];
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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    self.navigationController.fd_fullscreenPopGestureRecognizer.enabled  = (self.seletedIndex == 0);
//    self.navigationController.interactivePopGestureRecognizer.enabled = (self.seletedIndex == 0);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

//    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (JXPagerListRefreshView *)preferredPagingView {
    return [[JXPagerListRefreshView alloc] initWithDelegate:self listContainerType:JXPagerListContainerType_CollectionView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

}

#pragma mark - JXPagerViewDelegate

- (UIView *)tableHeaderViewInPagerView:(JXPagerView *)pagerView {
    
    return [UIView new];
}

- (NSUInteger)tableHeaderViewHeightInPagerView:(JXPagerView *)pagerView {
    return 0;
}

- (NSUInteger)heightForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return 248;
}

- (UIView *)viewForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return self.sectionView;
}

- (NSInteger)numberOfListsInPagerView:(JXPagerView *)pagerView {
    //和categoryView的item数量一致
    return 2;
}

- (id<JXPagerViewListViewDelegate>)pagerView:(JXPagerView *)pagerView initListAtIndex:(NSInteger)index {
    if (index == 0) {
        TerminalTransfOneVC *list = [[TerminalTransfOneVC alloc] init];
        return list;
    }else{
        TerminalTransfTwoVC *list1 = [[TerminalTransfTwoVC alloc] init];
        return list1;
    }
  
}



#pragma mark - JXPagerMainTableViewGestureDelegate

- (BOOL)mainTableViewGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    //禁止categoryView左右滑动的时候，上下和左右都可以滚动
//    if (otherGestureRecognizer == self.categoryView.collectionView.panGestureRecognizer) {
//        return NO;
//    }
    return [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]];
}


- (IBAction)headerBtnAC:(UIButton *)sender {
    
    NSInteger tag = sender.tag;
    [self handerHeadrBWithIndex:(int)tag - 100];
    [self.pagerView.listContainerView.scrollView setContentOffset:CGPointMake(kScreenWidth * (tag - 100), 0) animated:NO];
    [self.pagerView.listContainerView didClickSelectedItemAtIndex:tag - 100];
//    self.navigationController.fd_fullscreenPopGestureRecognizer.enabled = (self.seletedIndex == 0);
}



@end
