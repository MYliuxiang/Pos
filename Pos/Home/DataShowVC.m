//
//  DataShowVC.m
//  Pos
//
//  Created by tenvine on 2021/6/18.
//

#import "DataShowVC.h"
#import "DataModel.h"
#import "DataSCell.h"
#import "DataSSubCell.h"

@interface DataShowVC ()<WSTableViewDelegate>

@property (weak, nonatomic) IBOutlet WSTableView *wsTableView;

@property (nonatomic, strong)NSMutableArray *activeDataSourceArrM;
@property (nonatomic, strong)NSMutableArray *monthDataSourceArrM;
@property (nonatomic, strong)NSMutableArray *todayDataSourceArrM;


@property (nonatomic, strong)DataModel *active;
@property (nonatomic, strong)DataModel *month;
@property (nonatomic, strong)DataModel *today;


@end

@implementation DataShowVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.title = @"数据展示";
   
    self.activeDataSourceArrM = [NSMutableArray array];
    self.monthDataSourceArrM = [NSMutableArray array];
    self.todayDataSourceArrM = [NSMutableArray array];

    self.wsTableView.estimatedRowHeight = 44;
    self.wsTableView.rowHeight = UITableViewAutomaticDimension;
    self.wsTableView.WSTableViewDelegate = self;
    [self registerCell];
    [self loadData];

}

- (void)registerCell {
   
    
    UINib *orderManagerNib = [UINib nibWithNibName:NSStringFromClass([DataSCell class]) bundle:nil];
    [self.wsTableView registerNib:orderManagerNib forCellReuseIdentifier:NSStringFromClass([DataSCell class])];
    
    UINib *orderProductNib = [UINib nibWithNibName:NSStringFromClass([DataSSubCell class]) bundle:nil];
    [self.wsTableView registerNib:orderProductNib forCellReuseIdentifier:NSStringFromClass([DataSSubCell class])];
    
  
}

- (void)loadData{
    
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_merc_data];
    entity.needCache = NO;
    [MBProgressHUD showHUDAddedTo:lxMbProgressView animated:YES];
    [BANetManager ba_request_GETWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 200){
            
            self.active = [DataModel mj_objectWithKeyValues:result[@"data"][@"active"]];
            self.month = [DataModel mj_objectWithKeyValues:result[@"data"][@"month"]];
            self.today = [DataModel mj_objectWithKeyValues:result[@"data"][@"today"]];

            for (DataChildrenModel *model in self.today.children) {
                WSTableviewDataModel *dataModel = [[WSTableviewDataModel alloc] init];
                dataModel.firstLevelStr = [NSString stringWithFormat:@"%@今日新增商户数(%ld户)",model.name,model.number];
                dataModel.shouldExpandSubRows = NO;
                if (model.number == 0) {
                    dataModel.expandable = NO;
                }else{
                    dataModel.expandable = YES;
                }
                [self.todayDataSourceArrM addObject:dataModel];
            }
            
            for (DataChildrenModel *model in self.month.children) {
                WSTableviewDataModel *dataModel = [[WSTableviewDataModel alloc] init];
                dataModel.firstLevelStr = [NSString stringWithFormat:@"%@本月新增商户数(%ld户)",model.name,model.number];
                dataModel.shouldExpandSubRows = NO;
                if (model.number == 0) {
                    dataModel.expandable = NO;
                }else{
                    dataModel.expandable = YES;
                }
                [self.monthDataSourceArrM addObject:dataModel];
            }
            
            for (DataChildrenModel *model in self.active.children) {
                WSTableviewDataModel *dataModel = [[WSTableviewDataModel alloc] init];
                dataModel.firstLevelStr = [NSString stringWithFormat:@"%@总激活商户数(%ld户)",model.name,model.number];
                dataModel.shouldExpandSubRows = NO;
                if (model.number == 0) {
                    dataModel.expandable = NO;
                }else{
                    dataModel.expandable = YES;
                }
                [self.activeDataSourceArrM addObject:dataModel];
            }
            
            [self.wsTableView reloadData];
        }
    } failureBlock:^(NSError *error) {

    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
}



#pragma mark - UITableViewDataSource & UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 48;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = [UIColor colorWithHexString:@"#FF7D01"];
    label.backgroundColor = [UIColor clearColor];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(view).offset(21);
        make.top.equalTo(view).offset(23);
    }];
    if (section == 0) {
        label.text = [NSString stringWithFormat:@"今日新增商户数：%@户",self.today.total];

    }else if(section == 1){
        label.text = [NSString stringWithFormat:@"本月新增商户数：%@户",self.month.total];

    }else{
        label.text = [NSString stringWithFormat:@"团队总激活商户数：%@户",self.active.total];

    }


    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.active) {
        return 3;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return [self.todayDataSourceArrM count];
    }else if (section == 1){
        return [self.monthDataSourceArrM count];
    }else{
        return [self.activeDataSourceArrM count];
    }
}

- (NSInteger)tableView:(WSTableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath {
    WSTableviewDataModel *dataModel;
    if (indexPath.section == 0) {
        dataModel = self.todayDataSourceArrM[indexPath.row];
    }else if (indexPath.section == 1){
        dataModel = self.monthDataSourceArrM[indexPath.row];

    }else{
        dataModel = self.activeDataSourceArrM[indexPath.row];

    }
    return [dataModel.secondLevelArrM count];
}

- (BOOL)tableView:(WSTableView *)tableView shouldExpandSubRowsOfCellAtIndexPath:(NSIndexPath *)indexPath {
    WSTableviewDataModel *dataModel;
    if (indexPath.section == 0) {
        dataModel = self.todayDataSourceArrM[indexPath.row];
    }else if (indexPath.section == 1){
        dataModel = self.monthDataSourceArrM[indexPath.row];

    }else{
        dataModel = self.activeDataSourceArrM[indexPath.row];

    }
    return dataModel.shouldExpandSubRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WSTableviewDataModel *dataModel;
    if (indexPath.section == 0) {
        dataModel = self.todayDataSourceArrM[indexPath.row];
    }else if (indexPath.section == 1){
        dataModel = self.monthDataSourceArrM[indexPath.row];

    }else{
        dataModel = self.activeDataSourceArrM[indexPath.row];

    }
  
    DataSCell *cell =
    [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DataSCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell.lab.text = dataModel.firstLevelStr;
    cell.expandable = dataModel.expandable;
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath {
    WSTableviewDataModel *dataModel;
    if (indexPath.section == 0) {
        dataModel = self.todayDataSourceArrM[indexPath.row];
    }else if (indexPath.section == 1){
        dataModel = self.monthDataSourceArrM[indexPath.row];
        
    }else{
        dataModel = self.activeDataSourceArrM[indexPath.row];
    }
    DataSSubCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DataSSubCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    Profit *model = [dataModel object_get_fromSecondLevelArrMWithIndex:indexPath.subRow];
    cell.nameL.text = model.name;
    cell.numberL.text = model.number;
    //        cell.productNamelabel.text = [dataModel object_get_fromSecondLevelArrMWithIndex:indexPath.subRow];
    //        cell.bottomHeightConstraint.constant = indexPath.subRow == dataModel.secondLevelArrM.count - 1 ? 0.0f : 5.0f;
    return cell;
  
}

- (CGFloat)tableView:(WSTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(WSTableView *)tableView heightForSubRowAtIndexPath:(NSIndexPath *)indexPath {
    WSTableviewDataModel *dataModel = self.activeDataSourceArrM[indexPath.section];
    
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WSTableviewDataModel *dataModel;
    if (indexPath.section == 0) {
        dataModel = self.todayDataSourceArrM[indexPath.row];
    }else if (indexPath.section == 1){
        dataModel = self.monthDataSourceArrM[indexPath.row];

    }else{
        dataModel = self.activeDataSourceArrM[indexPath.row];
    }
    if (!dataModel.isLoad && dataModel.expandable) {
        [self loadDetailDataWithIndex:indexPath];
    }else{
        dataModel.shouldExpandSubRows = !dataModel.shouldExpandSubRows;
    }

}

- (void)loadDetailDataWithIndex:(NSIndexPath*)indexPath{
    
    BADataEntity *entity = [BADataEntity new];
    DataChildrenModel *oModel;
    WSTableviewDataModel *dataModel;

    if (indexPath.section == 0) {
        entity.urlString = [NSString stringWithFormat:@"%@%@%@",MainUrl,Url_merc_data,@"today"];
        dataModel = self.todayDataSourceArrM[indexPath.row];
        oModel = self.today.children[indexPath.row];
    }else if (indexPath.section == 1){
        entity.urlString = [NSString stringWithFormat:@"%@%@%@",MainUrl,Url_merc_data,@"month"];
        dataModel = self.monthDataSourceArrM[indexPath.row];
        oModel = self.month.children[indexPath.row];

    }else{
        entity.urlString = [NSString stringWithFormat:@"%@%@%@",MainUrl,Url_merc_data,@"active"];
        dataModel = self.activeDataSourceArrM[indexPath.row];
        oModel = self.active.children[indexPath.row];

    }
   
    entity.needCache = NO;
    entity.parameters = @{@"subId":oModel.did};
    [MBProgressHUD showHUDAddedTo:lxMbProgressView animated:YES];
    [BANetManager ba_request_GETWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 200){
            
            NSArray *datas = [Profit mj_objectArrayWithKeyValuesArray:result[@"data"]];
            
                        
            for (Profit *model in datas) {
                [dataModel object_add_toSecondLevelArrM:model];
            }
            dataModel.isLoad = YES;
            dataModel.shouldExpandSubRows = !dataModel.shouldExpandSubRows;
            [self.wsTableView refreshData];

           
        }
    } failureBlock:^(NSError *error) {

    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
}


- (void)tableView:(WSTableView *)tableView didSelectSubRowAtIndexPath:(NSIndexPath *)indexPath {
}




@end
