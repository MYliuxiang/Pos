//
//  TrdeDataVC.m
//  Pos
//
//  Created by tenvine on 2021/7/1.
//

#import "TrdeDataVC.h"
#import "TradeDCell.h"
#import "TradeDSubCell.h"

@interface TrdeDataVC ()<WSTableViewDelegate>
@property (weak, nonatomic) IBOutlet WSTableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataSourceArrM;
@property (nonatomic, strong)NSMutableArray *dataList;


@end

@implementation TrdeDataVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.title = @"交易数据";
    self.dataSourceArrM = [NSMutableArray array];
    self.dataList = [NSMutableArray array];
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.WSTableViewDelegate = self;
    [self registerCell];
    
    [self loadData];
    
//    [self addData];
}

- (void)loadData{
    
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_trade_info];
    entity.needCache = NO;
    [MBProgressHUD showHUDAddedTo:lxMbProgressView animated:YES];
    [BANetManager ba_request_GETWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 200){
            
            self.dataList = [Profit mj_objectArrayWithKeyValuesArray:result[@"data"]];
            for (Profit *model in self.dataList) {
                WSTableviewDataModel *dataModel = [[WSTableviewDataModel alloc] init];
                dataModel.firstLevelStr = [NSString stringWithFormat:@"%@%@",model.name,model.value];
                dataModel.shouldExpandSubRows = NO;
                [self.dataSourceArrM addObject:dataModel];
            }
            [self.tableView reloadData];
        }
    } failureBlock:^(NSError *error) {

    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
}


- (void)registerCell {
   
    
    UINib *orderManagerNib = [UINib nibWithNibName:NSStringFromClass([TradeDCell class]) bundle:nil];
    [self.tableView registerNib:orderManagerNib forCellReuseIdentifier:NSStringFromClass([TradeDCell class])];
    
    UINib *orderProductNib = [UINib nibWithNibName:NSStringFromClass([TradeDSubCell class]) bundle:nil];
    [self.tableView registerNib:orderProductNib forCellReuseIdentifier:NSStringFromClass([TradeDSubCell class])];
    
  
}

- (void)addData {
    
    self.tableView.WSTableViewDelegate = self;
    self.tableView.separatorColor = [UIColor whiteColor];
    
    _dataSourceArrM = [NSMutableArray array];
    WSTableviewDataModel *dataModel = [[WSTableviewDataModel alloc] init];
    dataModel.firstLevelStr = @"医院选择";
    dataModel.shouldExpandSubRows = NO;
    [dataModel object_add_toSecondLevelArrM:@"医院1"];
    [dataModel object_add_toSecondLevelArrM:@"医院2"];
    [dataModel object_add_toSecondLevelArrM:@"医院3"];
    [dataModel object_add_toSecondLevelArrM:@"医院4"];
    [_dataSourceArrM addObject:dataModel];
    
    WSTableviewDataModel *dataModel2 = [[WSTableviewDataModel alloc] init];
    dataModel2.firstLevelStr = @"部位选择";
    //dataModel2.shouldExpandSubRows = YES;
    [dataModel2 object_add_toSecondLevelArrM:@"腿"];
    [dataModel2 object_add_toSecondLevelArrM:@"脚"];
    [dataModel2 object_add_toSecondLevelArrM:@"头"];
    [_dataSourceArrM addObject:dataModel2];
    
    
    WSTableviewDataModel *dataModel3 = [[WSTableviewDataModel alloc] init];
    dataModel3.firstLevelStr = @"部位选择2";
    [dataModel3 object_add_toSecondLevelArrM:@"腿2"];
    [dataModel3 object_add_toSecondLevelArrM:@"脚2"];
    dataModel3.expandable = YES;
    [_dataSourceArrM addObject:dataModel3];
    
   
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];

    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.dataSourceArrM.count == 0) {
        return 0;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataSourceArrM count];
}

- (NSInteger)tableView:(WSTableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath {
    WSTableviewDataModel *dataModel = _dataSourceArrM[indexPath.row];
    return [dataModel.secondLevelArrM count];
}

- (BOOL)tableView:(WSTableView *)tableView shouldExpandSubRowsOfCellAtIndexPath:(NSIndexPath *)indexPath {
    WSTableviewDataModel *dataModel = _dataSourceArrM[indexPath.row];
    return dataModel.shouldExpandSubRows;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WSTableviewDataModel *dataModel = _dataSourceArrM[indexPath.row];
    TradeDCell *cell =
    [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TradeDCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.expandable = dataModel.expandable;
    cell.expanded = YES;
    cell.timeL.text = dataModel.firstLevelStr;
    cell.timeL.font = [UIFont boldSystemFontOfSize:16];
    cell.timeL.textColor = [UIColor colorWithHexString:@"#FF7D01"];
    cell.backgroundColor = Color_bg;
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath {
    WSTableviewDataModel *dataModel = _dataSourceArrM[indexPath.row];
    
    TradeDSubCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TradeDSubCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    Profit *model = [dataModel object_get_fromSecondLevelArrMWithIndex:indexPath.subRow];
    cell.cardL.hidden = YES;
    cell.timeL.text = model.name;
    cell.moneyL.text = [NSString stringWithFormat:@"￥%@",model.value];
    cell.timeL.font = [UIFont boldSystemFontOfSize:14];
    cell.timeL.textColor = [UIColor colorWithHexString:@"#282828"];
    
    cell.moneyL.font = [UIFont boldSystemFontOfSize:14];
    cell.moneyL.textColor = [UIColor colorWithHexString:@"#282828"];
    return cell;
  
}

- (CGFloat)tableView:(WSTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(WSTableView *)tableView heightForSubRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WSTableviewDataModel *dataModel = _dataSourceArrM[indexPath.row];
    if (dataModel.isLoad) {
        dataModel.shouldExpandSubRows = !dataModel.shouldExpandSubRows;
    }else{
        [self loadDetailDataWithIndex:indexPath.row];
    }

}

- (void)loadDetailDataWithIndex:(NSInteger)index{
    
    Profit *model = self.dataList[index];
    
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_trade_infoDetail];
    entity.needCache = NO;
    entity.parameters = @{@"month":model.month};
    [MBProgressHUD showHUDAddedTo:lxMbProgressView animated:YES];
    [BANetManager ba_request_GETWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 200){
            
            NSArray *datas = [Profit mj_objectArrayWithKeyValuesArray:result[@"data"]];
            WSTableviewDataModel *dataModel = self.dataSourceArrM[index];
            for (Profit *model in datas) {
                [dataModel object_add_toSecondLevelArrM:model];
            }
            dataModel.isLoad = YES;
            dataModel.shouldExpandSubRows = !dataModel.shouldExpandSubRows;
            [self.tableView refreshData];



           
        }
    } failureBlock:^(NSError *error) {

    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
}





- (void)tableView:(WSTableView *)tableView didSelectSubRowAtIndexPath:(NSIndexPath *)indexPath {
}





@end
