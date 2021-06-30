//
//  AchievementDetailVC.m
//  Pos
//
//  Created by tenvine on 2021/6/24.
//

#import "AchievementDetailVC.h"
#import "AchDetailSubVC.h"

@interface AchievementDetailVC ()<JXCategoryListContainerViewDelegate,JXCategoryViewDelegate>
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;
@property (nonatomic, strong) JXCategoryTitleBackgroundView *categoryView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic,strong) NSMutableArray *agents;
@end

@implementation AchievementDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.title = @"业绩详情";
    self.bottomView.hidden = YES;
    self.agents = [NSMutableArray array];
    [self loadData];
//    [self setUI];
   
}

- (void)setUI{
    
    
    self.titles = @[@"按日查询",@"按月查询"];
    self.categoryView.titles = self.titles;
    self.categoryView.titleFont = [UIFont boldSystemFontOfSize:16];
    self.categoryView.titleSelectedFont = [UIFont boldSystemFontOfSize:16];
    self.categoryView.titleColor = [UIColor colorWithHexString:@"#FF8901"];
    self.categoryView.titleSelectedColor = [UIColor whiteColor];
//    self.categoryView.contentEdgeInsetLeft = 15;
//    self.categoryView.contentEdgeInsetRight = 15;
    self.categoryView.cellWidthIncrement = 56;
    self.categoryView.averageCellSpacingEnabled = YES;
    
    self.categoryView.normalBackgroundColor = [UIColor whiteColor];
    self.categoryView.selectedBackgroundColor = [UIColor colorWithHexString:@"#FF8901"];
    self.categoryView.backgroundHeight = 35;
    self.categoryView.backgroundCornerRadius = 17.5;
    self.categoryView.cellSpacing = 10;
    
    [self.view addSubview:self.categoryView];
    [self.view addSubview:self.listContainerView];
    [self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.view).offset(Height_NavBar);

            make.height.mas_equalTo(70);
    }];
    [self.listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.categoryView.mas_bottom);
        make.bottom.equalTo(self.view).offset(-kBottomSafeHeight);

    }];
    
}

- (void)loadData{

    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_proxyResults_list];
    entity.needCache = NO;
    [MBProgressHUD showHUDAddedTo:lxWindow animated:YES];
    
    [BANetManager ba_request_GETWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 200) {
            AgentModel *model = [AgentModel new];
            model.name = @"我的业绩";
            model.aid = @"";
            [self.agents addObject:model];
            NSArray *array = [AgentModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"rows"]];
            [self.agents addObjectsFromArray:array];
            [self setUI];
        }
                
    } failureBlock:^(NSError *error) {
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
    
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    // 处于第一个item的时候，才允许屏幕边缘手势返回
    self.navigationController.fd_fullscreenPopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    // 离开页面的时候，需要恢复屏幕边缘手势，不能影响其他页面
    self.navigationController.fd_fullscreenPopGestureRecognizer.enabled = YES;
}


// 分页菜单视图
- (JXCategoryBaseView *)categoryView {
    if (!_categoryView) {
        _categoryView = [[JXCategoryTitleBackgroundView alloc] init];
        
        _categoryView.delegate = self;
        
        // !!!: 将列表容器视图关联到 categoryView
        _categoryView.listContainer = self.listContainerView;
    }
    return _categoryView;
}

// 列表容器视图
- (JXCategoryListContainerView *)listContainerView {
    if (!_listContainerView) {
        _listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    }
    return _listContainerView;
}

#pragma mark - JXCategoryViewDelegate

// 点击选中或者滚动选中都会调用该方法。适用于只关心选中事件，不关心具体是点击还是滚动选中的。
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    // 侧滑手势处理
    self.navigationController.fd_fullscreenPopGestureRecognizer.enabled = (index == 0);
}

// 滚动选中的情况才会调用该方法
- (void)categoryView:(JXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

#pragma mark - JXCategoryListContainerViewDelegate

// 返回列表的数量
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titles.count;
}

// 返回各个列表菜单下的实例，该实例需要遵守并实现 <JXCategoryListContentViewDelegate> 协议
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    AchDetailSubVC *list = [[AchDetailSubVC alloc] init];
    list.agents = self.agents;
    list.type = index;
    return list;
}








@end
