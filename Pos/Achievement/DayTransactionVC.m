//
//  DayTransactionVC.m
//  Pos
//
//  Created by tenvine on 2021/6/25.
//

#import "DayTransactionVC.h"

@interface DayTransactionVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,copy) NSMutableArray *dataList;
@property(nonatomic,copy) NSString *totalCount;
@property(nonatomic,copy) NSString *sumMoney;

@end

@implementation DayTransactionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.title = @"当日总交易额";
    self.dataList = [NSMutableArray array];
    [self loadData];
  
    

}

- (void)loadData{
    BADataEntity *entity = [BADataEntity new];
    
    NSString *url;
    if (self.type == 0) {
        url = Url_proxyResults_tradDayList;
    }else{
        url = Url_proxyResults_tradDayListMonth;
    }
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,url];
    entity.needCache = NO;
    entity.parameters = @{@"id":self.agentModel.aid,@"time":self.model.time};
    [MBProgressHUD showHUDAddedTo:lxMbProgressView animated:YES];

    [BANetManager ba_request_GETWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 200) {
            
            self.dataList = [TransationModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"list"]];
            self.totalCount = [NSString stringWithFormat:@"%@",result[@"data"][@"list"]];
            self.sumMoney = [NSString stringWithFormat:@"%@",result[@"data"][@"sumMoney"]];
            [self.tableView reloadData];
          
        }
        
    } failureBlock:^(NSError *error) {
      

        
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
    LxSubTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LxSubTitleCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIView *lineView = [UIView new];
        lineView.frame = CGRectMake(0, 61, kScreenWidth, 1);
        lineView.backgroundColor = [UIColor colorWithHexString:@"#DCDCDC"];
        [cell.contentView addSubview:lineView];
        
    }
    
    TransationModel *model = self.dataList[indexPath.row];
    cell.lab1.text = model.name;
    cell.lab1.textColor = [UIColor colorWithHexString:@"#232323"];
    cell.lab1.font = [UIFont boldSystemFontOfSize:14];
    cell.lab2.text = model.countMoney;
    cell.lab2.textColor = [UIColor colorWithHexString:@"#BDBDBD"];
    
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
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];

    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont boldSystemFontOfSize:14];
    label.text = @"当日总交易额";
    label.textColor = [UIColor colorWithHexString:@"#FF8901"];
    label.backgroundColor = [UIColor clearColor];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(20);
        make.top.bottom.equalTo(view);
    }];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.font = [UIFont systemFontOfSize:14];
    label1.text = self.sumMoney;
    label1.textColor = [UIColor colorWithHexString:@"#BDBDBD"];
    label1.backgroundColor = [UIColor clearColor];
    [view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view).offset(-20);
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
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 62;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}



@end
