//
//  TransferRecordVC.m
//  Pos
//
//  Created by tenvine on 2021/6/25.
//

#import "TransferRecordVC.h"
#import "TransferRecordSubVC.h"

@interface TransferRecordVC ()<JXPagerViewDelegate, JXPagerMainTableViewGestureDelegate>
@property (nonatomic, strong) JXPagerListRefreshView *pagerView;
@property (strong, nonatomic) IBOutlet UIView *sectionView;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (nonatomic,assign) int seletedIndex;
@property (weak, nonatomic) IBOutlet UIView *headerUpView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *brandL;
@property (weak, nonatomic) IBOutlet UIImageView *brandI;
@property (weak, nonatomic) IBOutlet UIView *brandV;

@property (nonatomic,copy) NSString *keyword;


@end

@implementation TransferRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.title = @"调拨记录";
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
}

- (void)setUI{
    self.btn1.layer.cornerRadius = 17.5;
    self.btn1.layer.masksToBounds = YES;
    
    self.btn2.layer.cornerRadius = 17.5;
    self.btn2.layer.masksToBounds = YES;
    
    LXViewBorder(self.textField, 5);
    LXViewBorder(self.brandV, 5);
    
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"品牌搜索" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#BBBBBB"],NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    self.textField.attributedPlaceholder = attrString;
    
    
    [self.textField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    
    
    UIView *rightView = [[UIView alloc]init];
    rightView.size = CGSizeMake(44, 44);
    rightView.contentMode = UIViewContentModeCenter;
    UIImageView *rightImage = [[UIImageView alloc]init];
    rightImage.image = [UIImage imageNamed:@"搜索"];
    rightImage.frame = CGRectMake(11, 11, 20, 20);
    [rightView addSubview:rightImage];
    self.textField.rightView = rightView;
    self.textField.rightViewMode = UITextFieldViewModeAlways;
    
    UIView *leftView = [[UIView alloc]init];
    leftView.size = CGSizeMake(31 , 31);
    leftView.contentMode = UIViewContentModeCenter;
    self.textField.leftView = leftView;
    self.textField.leftViewMode = UITextFieldViewModeAlways;
   
  
}

- (IBAction)brandAC:(id)sender {
}


- (void)textFieldChange:(UITextField *)textField{
    
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];

        NSString *handleStr =  [self.textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (handleStr.length == 0) {
            self.textField.text = handleStr;
            return;
        }
    self.keyword = handleStr;
    [self performSelector:@selector(searchAC) withObject:nil afterDelay:1.f];
}

- (void)searchAC{

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
    return 160;
}

- (UIView *)viewForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return self.sectionView;
}

- (NSInteger)numberOfListsInPagerView:(JXPagerView *)pagerView {
    //和categoryView的item数量一致
    return 2;
}

- (id<JXPagerViewListViewDelegate>)pagerView:(JXPagerView *)pagerView initListAtIndex:(NSInteger)index {
    TransferRecordSubVC *list = [[TransferRecordSubVC alloc] init];
    return list;
    
    
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
}




@end
