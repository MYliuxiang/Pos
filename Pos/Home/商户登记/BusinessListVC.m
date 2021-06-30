//
//  BusinessListVC.m
//  Pos
//
//  Created by 刘翔 on 2021/6/23.
//

#import "BusinessListVC.h"
#import "BusinessListCell.h"
#import "MerchantDetailVC.h"

@interface BusinessListVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataList;

@end

@implementation BusinessListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.title = @"商户列表";
    self.dataList = [NSMutableArray array];
    self.tableView.mj_header = [LxResfreshHeader headerWithRefreshingBlock:^{
        self.pageNum = 1;
        [self loadData];
    }];
    
    self.tableView.mj_footer = [LxRefreshFooter footerWithRefreshingBlock:^{
        [self loadData];
        
    }];
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)loadData{
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@%@",MainUrl,Url_merc_reg_list,self.type];
    entity.needCache = NO;
    if (self.model) {
        entity.parameters = @{@"brandId":self.model.did,@"pageNum":@(self.pageNum),@"pageSize":@(PageSize)};

    }
    [BANetManager ba_request_GETWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 200) {
            
            NSArray *models = [MerchantModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"rows"]];
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
    BusinessListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BusinessListCell" owner:nil options:nil] lastObject];
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
        return [UIView new];
    }
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];

    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont boldSystemFontOfSize:14];
    label.text = [NSString stringWithFormat:@"总共%ld个用户",self.dataList.count];
    label.textColor = [UIColor colorWithHexString:@"#282828"];
    label.backgroundColor = [UIColor clearColor];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(20);
        make.top.bottom.equalTo(view);
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
    return 85;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MerchantDetailVC *vc = [MerchantDetailVC new];
    [self.navigationController pushViewController:vc animated:YES];
    
}





@end
