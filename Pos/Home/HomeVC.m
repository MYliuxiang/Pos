//
//  HomeVC.m
//  Pos
//
//  Created by tenvine on 2021/6/16.
//

#import "HomeVC.h"
#import "HomeOneCell.h"
#import "HomeTwoCell.h"
#import "DataShowVC.h"
#import "MerchantDetailVC.h"
#import "BusinessVC.h"
#import "TerminalManagerVC.h"
#import "LeranVC.h"
#import "UrgentAttentionVC.h"
#import "MerchantVC.h"
#import "TradeDetailVC.h"

@interface HomeVC ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIButton *headerB1;
@property (weak, nonatomic) IBOutlet UIButton *headerB2;
@property (weak, nonatomic) IBOutlet UIButton *headerB3;
@property (weak, nonatomic) IBOutlet UIButton *headerB4;
@property (weak, nonatomic) IBOutlet UIButton *headerB5;
@property (weak, nonatomic) IBOutlet UIView *headerCV;
@property (weak, nonatomic) IBOutlet UIView *headerCDownV;
@property (weak, nonatomic) IBOutlet UILabel *hederTotalL;
@property(nonatomic,strong) SDCycleScrollView *cycleView;
@property(nonatomic,copy) NSArray *cycleModels;
@property(nonatomic,copy) NSArray *activityModels;
@property(nonatomic,copy) NSArray *shopList;

@property (weak, nonatomic) IBOutlet UILabel *number1L;
@property (weak, nonatomic) IBOutlet UILabel *number2L;
@property (weak, nonatomic) IBOutlet UILabel *number3L;


@property (weak, nonatomic) IBOutlet UIView *cycleBgView;



@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.hidden = YES;
    [self setUI];
    
    self.headerView.autoresizingMask = UIViewAutoresizingNone;
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    
    [self.cycleBgView addSubview:self.cycleView];
//    self.cycleView.imageURLStringsGroup = @[[UIImage imageNamed:@"位图备份 4"],[UIImage imageNamed:@"位图备份 4"]];
    
//    self.tableView.mj_header = [LxResfreshHeader headerWithRefreshingBlock:^{
//        [self loadData];
//    }];
     LxResfreshHeader *header = [LxResfreshHeader headerWithRefreshingBlock:^{
        [self loadData];

    }];
                                
    header.mj_h =  kTopBarSafeHeight + 54;
    self.tableView.mj_header = header;
    
    [self.tableView.mj_header beginRefreshing];


}

- (void)loadData{
    dispatch_group_t dispatchGroup = dispatch_group_create();
    dispatch_group_enter(dispatchGroup);

    //轮播图
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@%@",MainUrl,Url_carousel_list,@"0"];
    entity.needCache = NO;
    [MBProgressHUD showHUDAddedTo:lxWindow animated:YES];

    [BANetManager ba_request_GETWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 200) {
            self.cycleModels = [CarouselModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"rows"]];
            
            NSMutableArray *marray = [NSMutableArray array];
            for (CarouselModel *model in self.cycleModels) {
                [marray addObject:model.imgUrl];
            }
            self.cycleView.imageURLStringsGroup = marray;
        }
          
        dispatch_group_leave(dispatchGroup);

        } failureBlock:^(NSError *error) {
            dispatch_group_leave(dispatchGroup);

        } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
            
        }];
    
    dispatch_group_enter(dispatchGroup);
    //活动
    BADataEntity *entity1 = [BADataEntity new];
    entity1.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_activity_list];
    entity1.needCache = NO;
    [MBProgressHUD showHUDAddedTo:lxWindow animated:YES];
    [BANetManager ba_request_GETWithEntity:entity1 successBlock:^(id response) {
           NSDictionary *result = response;
        if ([result[@"code"] intValue] == 200) {
            self.activityModels = [ActivityModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"rows"]];
            [self.tableView reloadRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] withRowAnimation:UITableViewRowAnimationNone];
        }
 
                
        dispatch_group_leave(dispatchGroup);


        } failureBlock:^(NSError *error) {
            dispatch_group_leave(dispatchGroup);

        } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {

        }];
    
    dispatch_group_enter(dispatchGroup);
    BADataEntity *entity2 = [BADataEntity new];
    entity2.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_shopItem_list];
    entity2.needCache = NO;
    [MBProgressHUD showHUDAddedTo:lxWindow animated:YES];
    [BANetManager ba_request_GETWithEntity:entity2 successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 200) {
            self.shopList = [ShopItemModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"rows"]];
            [self.tableView reloadRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] withRowAnimation:UITableViewRowAnimationNone];
        }
      
                
        dispatch_group_leave(dispatchGroup);


        } failureBlock:^(NSError *error) {
            dispatch_group_leave(dispatchGroup);

        } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {

        }];
    
    dispatch_group_enter(dispatchGroup);
    BADataEntity *entity3 = [BADataEntity new];
    entity3.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_merc_index];
    entity3.needCache = NO;
    [MBProgressHUD showHUDAddedTo:lxWindow animated:YES];
    [BANetManager ba_request_GETWithEntity:entity3 successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 200) {
            self.hederTotalL.text = [NSString stringWithFormat:@"%.2f", [result[@"data"][@"indexMoney"] floatValue]];
            self.number1L.text = [NSString stringWithFormat:@"%d",[result[@"data"][@"today"] intValue]];
            self.number2L.text = [NSString stringWithFormat:@"%d",[result[@"data"][@"active"] intValue]];
            
            self.number3L.text = [NSString stringWithFormat:@"%d",[result[@"data"][@"month"] intValue]];
        }
    
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

- (SDCycleScrollView *)cycleView
{
    if (_cycleView == nil) {
        _cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth,kScreenWidth / 424 * 178) delegate:self placeholderImage:nil];
        _cycleView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
//        _cycleView.pageDotImage = [UIImage imageNamed:@"switch opacity"];
//        _cycleView.currentPageDotImage = [UIImage imageNamed:@"switch"];
        _cycleView.backgroundColor = [UIColor clearColor];

    }
    return _cycleView;
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    CarouselModel *model = self.cycleModels[index];
    HWBaseWebViewController *vc = [HWBaseWebViewController new];
    vc.urlString = model.jumpUrl;
//    vc.urlString = @"http://www.baidu.com";
    
//    HWBaseWebViewController *vc = [HWBaseWebViewController new];
//    vc.urlString = [NSString stringWithFormat:@"%@%@?id=%@",H5MainUrl,H5_StudyDetai,model.sid];
//    [self.navigationController pushViewController:vc animated:YES];

//    [self.navigationController pushViewController:vc animated:YES];

}


- (void)viewDidLayoutSubviews {
    
    
    [super viewDidLayoutSubviews];
    {
        CGFloat height = [self.tableView.tableFooterView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        CGRect footerFrame = self.tableView.tableFooterView.frame;
        footerFrame.size.height = height;
        self.tableView.tableFooterView.frame = footerFrame;
        self.tableView.tableFooterView = self.tableView.tableFooterView;
    }
    {
        CGFloat height = [self.tableView.tableHeaderView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        CGRect headerFrame = self.tableView.tableHeaderView.frame;
        headerFrame.size.height = height;
        self.tableView.tableHeaderView.frame = headerFrame;
        self.tableView.tableHeaderView = self.tableView.tableHeaderView;
    }
}

- (void)setUI{
    [self.headerB1 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:9];
    [self.headerB2 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:9];
    [self.headerB3 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:9];
    [self.headerB4 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:9];
    [self.headerB5 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:9];
    
    self.headerCV.layer.cornerRadius=10;
    self.headerCV.layer.shadowColor=[UIColor blackColor].CGColor;
    self.headerCV.layer.shadowOffset=CGSizeMake(5, 5);
    self.headerCV.layer.shadowOpacity=0.3;
    self.headerCV.layer.shadowRadius=5;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerClick)];
    [self.headerCDownV addGestureRecognizer:tap];
    
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapheaderTitle)];
    self.hederTotalL.userInteractionEnabled = YES;
    [self.hederTotalL addGestureRecognizer:tap1];
    

      
}

- (void)tapheaderTitle {
    
    MerchantDetailVC *vc = [MerchantDetailVC new];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)headerBottomAC:(UIButton *)sender {
    
    NSInteger tag = sender.tag;
    switch (tag - 100) {
        case 0:
        {
            //商户登记
            MerchantVC *vc = [MerchantVC new];
            [self.navigationController pushViewController:vc animated:YES];

            
        }
            break;
        case 1:
        {
            //终端管理
            TerminalManagerVC *vc = [TerminalManagerVC new];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
            
        case 2:
        {
            //业务拓展
            BusinessVC *vc = [BusinessVC new];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
            
        case 3:
        {
            //学习讲堂
            LeranVC *vc = [LeranVC new];
            [self.navigationController pushViewController:vc animated:YES];
            
            
        }
            break;
            
        case 4:
        {
            //紧急关注
            UrgentAttentionVC *vc = [UrgentAttentionVC new];
            [self.navigationController pushViewController:vc animated:YES];
            
            
        }
            break;
            
            
        default:
            break;
    }
    
}





- (void)headerClick{
    DataShowVC *vc = [DataShowVC new];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
  
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.headerCDownV.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = self.headerCDownV.bounds;
    maskLayer.path = maskPath.CGPath;
    self.headerCDownV.layer.mask = maskLayer;
}

#pragma  mark --------UITableView Delegete----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        static NSString *identifire = @"cellID";
        HomeOneCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"HomeOneCell" owner:nil options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        cell.dataList = self.shopList;
            
        return cell;
    }else{
        static NSString *identifire = @"cellID2";
        HomeTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"HomeTwoCell" owner:nil options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        cell.dataList = self.activityModels;
        
        return cell;
    }
   
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.1;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
    
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
