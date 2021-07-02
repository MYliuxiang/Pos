//
//  TradeDetailVC.m
//  Pos
//
//  Created by 刘翔 on 2021/6/23.
//

#import "TradeDetailVC.h"
#import "TradeDCell.h"
#import "TradeDSubCell.h"

@interface TradeDetailVC ()<WSTableViewDelegate>
@property (weak, nonatomic) IBOutlet WSTableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataSourceArrM;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *headerL;

@end

@implementation TradeDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.title = @"交易明细";
    self.tableView.WSTableViewDelegate = self;
    self.dataSourceArrM = [NSMutableArray array];
    self.headerL.preferredMaxLayoutWidth = kScreenWidth - 20;
    self.tableView.tableHeaderView = self.headerView;
    [self registerCell];
    [self loadData];

 }

- (void)loadData{
    
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@?deviceNo=%@&mercNo=%@",MainUrl,Url_trade_list,self.deviceNo,self.mercNo];
    entity.needCache = NO;
    [MBProgressHUD showHUDAddedTo:lxMbProgressView animated:YES];
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 200){
            NSArray *array = result[@"data"];
            for (NSString *month in array) {
                WSTableviewDataModel *dataModel = [[WSTableviewDataModel alloc] init];
                dataModel.firstLevelStr = [NSString stringWithFormat:@"%@",month];
                dataModel.shouldExpandSubRows = NO;
                [self.dataSourceArrM addObject:dataModel];
            }
            [self.tableView reloadData];
            
        }
    } failureBlock:^(NSError *error) {

    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    {
        CGFloat height = [self.tableView.tableHeaderView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        CGRect headerFrame = self.tableView.tableHeaderView.frame;
        headerFrame.size.height = height;
        self.tableView.tableHeaderView.frame = headerFrame;
        self.tableView.tableHeaderView = self.tableView.tableHeaderView;
    }
}

 - (void)registerCell {
    
     
     UINib *orderManagerNib = [UINib nibWithNibName:NSStringFromClass([TradeDCell class]) bundle:nil];
     [self.tableView registerNib:orderManagerNib forCellReuseIdentifier:NSStringFromClass([TradeDCell class])];
     
     UINib *orderProductNib = [UINib nibWithNibName:NSStringFromClass([TradeDSubCell class]) bundle:nil];
     [self.tableView registerNib:orderProductNib forCellReuseIdentifier:NSStringFromClass([TradeDSubCell class])];
     
   
 }



 #pragma mark - UITableViewDataSource & UITableViewDelegate
 - (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
     return 0;
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
     return cell;
 }

 - (UITableViewCell *)tableView:(UITableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath {
     WSTableviewDataModel *dataModel = _dataSourceArrM[indexPath.row];
     
     TradeDSubCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TradeDSubCell class])];
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     TradeDetailModel *model = [dataModel object_get_fromSecondLevelArrMWithIndex:indexPath.subRow];
     cell.timeL.text = model.tradeTime;
     cell.moneyL.text = model.amount;
//     卡类型 借贷标识 1 借记 2 贷记 3 境外卡 扫码交易为空
     if (model.cardFlag == 1) {
         cell.cardL.text = @"借记卡";
     }else if (model.cardFlag == 2){
         cell.cardL.text = @"贷记卡";
     }else{
         cell.cardL.text = @"境外卡";

     }
     
     return cell;
   
 }

 - (CGFloat)tableView:(WSTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
     return 76;
 }

 - (CGFloat)tableView:(WSTableView *)tableView heightForSubRowAtIndexPath:(NSIndexPath *)indexPath {
     
     return 56;
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
    
    WSTableviewDataModel *dataModel = _dataSourceArrM[index];

    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@?deviceNo=%@&mercNo=%@&tradeDate=%@",MainUrl,Url_trade_monthInfoList,self.deviceNo,self.mercNo,dataModel.firstLevelStr];
    entity.needCache = NO;
    [MBProgressHUD showHUDAddedTo:lxMbProgressView animated:YES];
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 200){
            
            NSArray *datas = [TradeDetailModel mj_objectArrayWithKeyValuesArray:result[@"data"]];
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
