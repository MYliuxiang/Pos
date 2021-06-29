//
//  AchievementVC.m
//  Pos
//
//  Created by tenvine on 2021/6/16.
//

#import "AchievementVC.h"
#import "AchievementCell.h"
#import "AchievementDetailVC.h"

@interface AchievementVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *footerView;
@property (weak, nonatomic) IBOutlet UIButton *achievementB;
@property (nonatomic, strong) NSMutableArray *dataList;

@end

@implementation AchievementVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.title = @"业绩";
    self.dataList = [NSMutableArray array];

    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
    
   
    
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.mj_header = [LxResfreshHeader headerWithRefreshingBlock:^{
        self.pageNum = 1;
        [self loadData];
    }];
    
//    self.tableView.mj_footer = [LxRefreshFooter footerWithRefreshingBlock:^{
//        [self loadData];
//
//    }];
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)loadData{
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_proxy_tradingResultsMonthMoney];
    entity.needCache = NO;
    entity.parameters = @{@"pageNum":@(self.pageNum),@"pageSize":@(PageSize)};

    [BANetManager ba_request_GETWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 200) {
            
            NSArray *models = [AchievementModel mj_objectArrayWithKeyValuesArray:result[@"data"]];
            if (self.pageNum == 1) {
                [self.dataList removeAllObjects];
            }
            [self.dataList addObjectsFromArray:models];
//            self.pageNum++;
            
//            if ([result[@"data"][@"total"] intValue] == self.dataList.count) {
//                [self.tableView.mj_footer endRefreshingWithNoMoreData];
//            }else{
//                [self.tableView.mj_footer endRefreshing];
//            }
            [self.tableView.mj_header endRefreshing];
            self.footerView.height = 130;
            self.tableView.tableFooterView = self.footerView;
            LXViewBorder(self.achievementB, 22);
            [self.tableView reloadData];

        }else{
            
//            [self.tableView.mj_footer endRefreshing];
            [self.tableView.mj_header endRefreshing];

        }
        
    } failureBlock:^(NSError *error) {
//        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];

        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
    
}



- (IBAction)detailAC:(id)sender {
    
    AchievementDetailVC *vc = [[AchievementDetailVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma  mark --------UITableView Delegete----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifire = @"cellID";
    AchievementCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AchievementCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    cell.model = self.dataList[indexPath.row];
    
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.1;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}



@end
