//
//  TerminalSDetailVC.m
//  Pos
//
//  Created by tenvine on 2021/6/24.
//

#import "TerminalSDetailVC.h"
#import "SearchTerminalVC.h"

@interface TerminalSDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (copy, nonatomic) NSArray *titles;
@property (copy, nonatomic) NSArray *values;
@property (copy, nonatomic) NSMutableArray *settings;




@end

@implementation TerminalSDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.title = @"查询详情";
    self.rightImageName = @"搜索";
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    self.values = [NSMutableArray array];
    self.settings = [NSMutableArray array];
    
  
  
    
    [self loadData];


}

- (void)loadData{
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@%@",MainUrl,Url_devicec_query,self.model.deviceNo];
    entity.needCache = NO;
    [MBProgressHUD showHUDAddedTo:lxMbProgressView animated:YES];
    [BANetManager ba_request_GETWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 200){
            self.titles = @[@"终端编号",@"返现到期",@"划拨人",@"绑定状态"];
            NSString *bindStr;
            if ([result[@"data"][@"bindStatus"] intValue] == 0) {
                bindStr = @"未绑定";
            }else{
                bindStr = @"已经绑定";
            }
            
            /*
             bindStatus = 1;
             bindTime = "<null>";
             deviceNo = 000099953;
             expired = "<null>";
             modelId = 1;
             owner = "\U674e\U6d0b";
             */
            self.values = @[[NSString stringWithFormat:@"%@",result[@"data"][@"deviceNo"]],[NSString stringWithFormat:@"%@",result[@"data"][@"expired"]],[NSString stringWithFormat:@"%@",result[@"data"][@"owner"]],bindStr];
            self.settings = [SettingModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"settings"]];
            [self.tableView reloadData];
          
        }
    } failureBlock:^(NSError *error) {

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
    
    return self.titles.count + self.settings.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifire = @"cellID";
    LxSubTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LxSubTitleCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#DCDCDC"];
        [cell.contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(cell.contentView);
            make.bottom.equalTo(cell.contentView);
            make.height.mas_equalTo(1);
        }];
        
    }
    
    cell.lab1.textColor = [UIColor colorWithHexString:@"#282828"];
    cell.lab2.textColor = [UIColor colorWithHexString:@"#C4C4C4"];

    if (indexPath.row < self.titles.count) {
        cell.lab1.text = self.titles[indexPath.row];
        cell.lab2.text = self.values[indexPath.row];
    }else{
        SettingModel *model = self.settings[indexPath.row - self.titles.count];
        cell.lab1.text = model.standard;
        cell.lab2.text = model.money;
    }
  
    
    
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
    if (self.titles.count == 0) {
        return 0.1;
    }
    return 76;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.titles.count == 0) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor clearColor];
        return view;
    }
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, 16, 120, 44);
    btn.backgroundColor = [UIColor whiteColor];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitle:@"累计交易额" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithHexString:@"#FF8901"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(transfAC) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];

    KViewBorderRadius(btn, 10, 1, [UIColor colorWithHexString:@"#D8D8D8"]);
    

    return view;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 53;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    
}

- (void)transfAC{
    //累积交易
    
    MerchantModel *model = [MerchantModel new];
    model.deviceNo = self.model.deviceNo;
    MerchantDetailVC *vc = [MerchantDetailVC new];
    vc.mmodel = model;
    [self.navigationController pushViewController:vc animated:YES];
}
@end

@implementation SettingModel

@end
