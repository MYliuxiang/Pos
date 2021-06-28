//
//  DirectAccessVC.m
//  Pos
//
//  Created by 刘翔 on 2021/6/25.
//

#import "DirectAccessVC.h"
#import "PrivateVC.h"
#import "ToPublicVC.h"
#import "UnincorporateVC.h"

@interface DirectAccessVC ()<JXCategoryListContainerViewDelegate,JXCategoryViewDelegate>
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;
@property (nonatomic, strong) JXCategoryTitleBackgroundView *categoryView;
@property (nonatomic, strong) NSArray *titles;

@end

@implementation DirectAccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.title = @"直接入网";
    [self.view addSubview:self.categoryView];
    [self.view addSubview:self.listContainerView];
    [self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.view).offset(Height_NavBar);

            make.height.mas_equalTo(70);
    }];
    [self.listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.categoryView.mas_bottom);
    }];
    

    self.titles = @[@"对私结算",@"对公结算",@"非法人结算"];
    self.categoryView.titles = self.titles;
    self.categoryView.titleFont = [UIFont boldSystemFontOfSize:16];
    self.categoryView.titleSelectedFont = [UIFont boldSystemFontOfSize:16];
    self.categoryView.titleColor = [UIColor colorWithHexString:@"#FF8901"];
    self.categoryView.titleSelectedColor = [UIColor whiteColor];
//    self.categoryView.contentEdgeInsetLeft = 15;
//    self.categoryView.contentEdgeInsetRight = 15;
    self.categoryView.cellWidthIncrement = 20;
    self.categoryView.averageCellSpacingEnabled = YES;
    
    self.categoryView.normalBackgroundColor = [UIColor whiteColor];
    self.categoryView.selectedBackgroundColor = [UIColor colorWithHexString:@"#FF8901"];
    self.categoryView.backgroundHeight = 35;
    self.categoryView.backgroundCornerRadius = 17.5;
    self.categoryView.cellSpacing = 10;
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
    
    if (index == 0) {
        PrivateVC *list = [[PrivateVC alloc] init];
        return list;
    }else if (index == 1){
        ToPublicVC *list = [[ToPublicVC alloc] init];
        return list;
    }else{
        UnincorporateVC *list = [[UnincorporateVC alloc] init];
        return list;
    }
    
}



@end
