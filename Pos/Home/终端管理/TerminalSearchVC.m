//
//  TerminalSearchVC.m
//  Pos
//
//  Created by tenvine on 2021/6/24.
//

#import "TerminalSearchVC.h"
#import "TerSearchCell.h"
#import "TerminalSDetailVC.h"
#import "SearchTerminalVC.h"

@interface TerminalSearchVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataList;

@end

@implementation TerminalSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.title = @"终端查询";
    self.rightImageName = @"搜索";
    self.dataList = [NSMutableArray array];
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    
    self.tableView.mj_header = [LxResfreshHeader headerWithRefreshingBlock:^{
        self.pageNum = 1;
        [self loadData];
    }];
    
    self.tableView.mj_footer = [LxRefreshFooter footerWithRefreshingBlock:^{
        [self loadData];
        
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header beginRefreshing];

    });
    
}

- (void)loadData{
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_devicec_query];
    entity.needCache = NO;
    entity.parameters = @{@"pageNum":@(self.pageNum),@"pageSize":@(PageSize)};
    [BANetManager ba_request_GETWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 200) {
            
            NSArray *models = [TerminalModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"rows"]];
            if (self.pageNum == 1) {
                [self.dataList removeAllObjects];
            }
            [self.dataList addObjectsFromArray:models];
            self.pageNum++;
            
            if ([result[@"data"][@"total"] intValue] == self.dataList.count) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.tableView.mj_footer endRefreshing];
            }
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
          
        }else{
            
            [self.tableView.mj_footer endRefreshing];
            [self.tableView.mj_header endRefreshing];

        }
        
    } failureBlock:^(NSError *error) {
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];

        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
    
}


- (void)doRightNavBarRightBtnAction{
    //搜索
    SearchTerminalVC *vc = [SearchTerminalVC new];
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
    TerSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TerSearchCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    cell.model = self.dataList[indexPath.row];
    
    
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.dataList.count == 0) {
        return 0.1;
    }
    return 44;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.dataList.count == 0) {
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor clearColor];
        return view ;
    }
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];

    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont boldSystemFontOfSize:14];
    label.text = @"我的终端";
    label.textColor = [UIColor colorWithHexString:@"#282828"];
    label.backgroundColor = [UIColor clearColor];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(20);
        make.top.bottom.equalTo(view);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#DCDCDC"];
    [view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(view);
        make.bottom.equalTo(view);
        make.height.mas_equalTo(1);
    }];
    
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 76;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TerminalSDetailVC *vc =[TerminalSDetailVC new];
    vc.model = self.dataList[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    
}





@end
