//
//  TerminalManagerVC.m
//  Pos
//
//  Created by 刘翔 on 2021/6/21.
//

#import "TerminalManagerVC.h"
#import "TerminalTransferVC.h"
#import "TerminalSearchVC.h"

@interface TerminalManagerVC ()<JXPagerViewDelegate, JXPagerMainTableViewGestureDelegate>
@property (nonatomic, strong) JXPagerView *pagerView;

@property (strong, nonatomic) IBOutlet UIView *headerV;
@property (strong, nonatomic) IBOutlet UIView *centerV;
@property (weak, nonatomic) IBOutlet UIButton *headerB1;
@property (weak, nonatomic) IBOutlet UIButton *headerB2;
@property (weak, nonatomic) IBOutlet UIButton *headerB3;

@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;

@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;
@property (weak, nonatomic) IBOutlet UIView *view5;
@property (weak, nonatomic) IBOutlet UIView *view6;
@property (weak, nonatomic) IBOutlet UILabel *count1;
@property (weak, nonatomic) IBOutlet UILabel *count2;
@property (weak, nonatomic) IBOutlet UILabel *count3;
@property (weak, nonatomic) IBOutlet UILabel *count4;
@property (weak, nonatomic) IBOutlet UILabel *count5;
@property (weak, nonatomic) IBOutlet UILabel *count6;
@property (weak, nonatomic) IBOutlet UILabel *title1;
@property (weak, nonatomic) IBOutlet UILabel *title2;
@property (weak, nonatomic) IBOutlet UILabel *title3;
@property (weak, nonatomic) IBOutlet UILabel *title4;
@property (weak, nonatomic) IBOutlet UILabel *title5;
@property (weak, nonatomic) IBOutlet UILabel *title6;

@property (nonatomic,copy) NSArray *views;
@property (nonatomic,copy) NSArray *titles;
@property (nonatomic,copy) NSArray *counts;
@property (nonatomic,copy) NSArray *titleStrs;

@property (nonatomic,strong) NSMutableArray *models;

@property (nonatomic,strong) BrandMangerModel *model;

@end

@implementation TerminalManagerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.title = @"终端管理";
    self.models = [NSMutableArray array];
    
    _pagerView = [self preferredPagingView];
    self.pagerView.mainTableView.gestureDelegate = self;
    self.pagerView.mainTableView.backgroundColor = [UIColor clearColor];
    self.pagerView.isListHorizontalScrollEnabled = NO;
    [self.view addSubview:self.pagerView];
    [self.pagerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(Height_NavBar);
            make.bottom.right.left.equalTo(self.view);
    }];
    self.views = @[self.view1,self.view2,self.view3,self.view4,self.view5,self.view6];
    self.titles = @[self.title1,self.title2,self.title3,self.title4,self.title5,self.title6];
    self.counts = @[self.count1,self.count2,self.count3,self.count4,self.count5,self.count6];
    self.titleStrs = @[@"未绑定",@"已绑定",@"已解绑",@"未返现",@"已返现",@"已过期"];
    [self setUI];
    [self loadData];
    
    
  
}

- (void)loadData{
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_device_manage];
    entity.needCache = NO;
    [MBProgressHUD showHUDAddedTo:lxMbProgressView animated:YES];
    
    [BANetManager ba_request_GETWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 200) {
            
            self.model = [BrandMangerModel mj_objectWithKeyValues:result[@"data"]];
                    
            [self.models addObject:self.model.unbound];
            [self.models addObject:self.model.binded];
            [self.models addObject:self.model.untied];
            [self.models addObject:self.model.noCashBack];
            [self.models addObject:self.model.cashBack];
            [self.models addObject:self.model.expired];

            
            
            [self handerCenterUIWithIndex:0];
            
            
            

            [self setUIData];
            [self.pagerView reloadData];
        }
        
        
    } failureBlock:^(NSError *error) {
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
    
}

- (void)setUIData{
    
    self.count1.text = self.model.unbound.count;
    self.count2.text = self.model.binded.count;
    self.count3.text = self.model.untied.count;
    self.count4.text = self.model.noCashBack.count;
    self.count5.text = self.model.cashBack.count;
    self.count6.text = self.model.expired.count;

}

- (void)setUI{
    [self.headerB1 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:30];
    [self.headerB2 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:30];
    [self.headerB3 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:30];
    
    for (UIView *view in self.views) {
        view.layer.cornerRadius = 10;
        view.layer.masksToBounds = YES;
        view.layer.borderWidth = 1;
    }

}


- (void)handerCenterUIWithIndex:(int)index{
    
    [self.pagerView.listContainerView.scrollView setContentOffset:CGPointMake(kScreenWidth * index, 0) animated:NO];
    [self.pagerView.listContainerView didClickSelectedItemAtIndex:index];
    
    
    
    for (int i = 0; i < self.views.count; i++) {
        UIView *view = self.views[i];
        UILabel *titleL = self.titles[i];
        UILabel *countL = self.counts[i];

        if (i == index) {
            view.backgroundColor = [UIColor colorWithHexString:@"#FF8901"];
            view.layer.borderColor = [UIColor colorWithHexString:@"#FF8901"].CGColor;
            titleL.textColor = countL.textColor = [UIColor whiteColor];
            
        }else{
            view.backgroundColor = [UIColor whiteColor];
            view.layer.borderColor = [UIColor colorWithHexString:@"#D8D8D8"].CGColor;
            titleL.textColor = countL.textColor = [UIColor colorWithHexString:@"#999999"];
        }
    }
    
//    switch (index) {
//        case 0:
//        {
//            self.vc.model = self.model.unbound;
//
//        }
//            break;
//        case 1:
//        {
//            self.vc.model = self.model.binded;
//
//        }
//            break;
//        case 2:
//        {
//            self.vc.model = self.model.untied;
//
//        }
//            break;
//        case 3:
//        {
//            self.vc.model = self.model.noCashBack;
//
//        }
//            break;
//        case 4:
//        {
//            self.vc.model = self.model.cashBack;
//
//        }
//            break;
//        case 5:
//        {
//            self.vc.model = self.model.expired;
//
//        }
//            break;
//
//        default:
//            break;
//    }
    
    
    
}

- (IBAction)headerAC:(UIButton *)sender {
    
    NSInteger tag = sender.tag;
    switch (tag - 100) {
        case 0:
        {
            //终端查询
            TerminalSearchVC *vc = [TerminalSearchVC new];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
        case 1:
        {
            //终端划拨
            TerminalTransferVC *vc = [TerminalTransferVC new];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
            
        case 2:
        {
            //终端回调
            TerminalTransferVC *vc = [TerminalTransferVC new];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
            
                   
        default:
            break;
    }
}

- (IBAction)centerAC:(UITapGestureRecognizer *)sender {
    
    UIView *view = sender.view;
    NSInteger tag = view.tag;
    [self handerCenterUIWithIndex:(int)(tag - 200)];
    
    
}



- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (JXPagerView *)preferredPagingView {
    return [[JXPagerView alloc] initWithDelegate:self];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

}

#pragma mark - JXPagerViewDelegate

- (UIView *)tableHeaderViewInPagerView:(JXPagerView *)pagerView {
    return self.headerV;
}

- (NSUInteger)tableHeaderViewHeightInPagerView:(JXPagerView *)pagerView {
    return 167;
}

- (NSUInteger)heightForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    if(self.model) return 261;
    return 0;
}

- (UIView *)viewForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    if(self.model) return self.centerV;
    return [UIView new];
}

- (NSInteger)numberOfListsInPagerView:(JXPagerView *)pagerView {
    //和categoryView的item数量一致
    return self.models.count;
}

- (id<JXPagerViewListViewDelegate>)pagerView:(JXPagerView *)pagerView initListAtIndex:(NSInteger)index {
    TerminalCenterVC *list = [[TerminalCenterVC alloc] init];
    list.model = self.models[index];
    list.headerTitle = self.titleStrs[index];
    return list;
}

#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
}

#pragma mark - JXPagerMainTableViewGestureDelegate

- (BOOL)mainTableViewGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    //禁止categoryView左右滑动的时候，上下和左右都可以滚动
//    if (otherGestureRecognizer == self.categoryView.collectionView.panGestureRecognizer) {
//        return NO;
//    }
    return [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]];
}





@end
