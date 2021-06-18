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

@property (nonatomic, strong)NSMutableArray *dataSourceArrM;



@end

@implementation DataShowVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.title = @"数据展示";
   
    self.dataSourceArrM = [NSMutableArray array];

    self.wsTableView.estimatedRowHeight = 44;
    self.wsTableView.rowHeight = UITableViewAutomaticDimension;


    [self registerCell];
    [self addData];

}

- (void)registerCell {
   
    
    UINib *orderManagerNib = [UINib nibWithNibName:NSStringFromClass([DataSCell class]) bundle:nil];
    [self.wsTableView registerNib:orderManagerNib forCellReuseIdentifier:NSStringFromClass([DataSCell class])];
    
    UINib *orderProductNib = [UINib nibWithNibName:NSStringFromClass([DataSSubCell class]) bundle:nil];
    [self.wsTableView registerNib:orderProductNib forCellReuseIdentifier:NSStringFromClass([DataSSubCell class])];
    
  
}

- (void)addData {
    
    self.wsTableView.WSTableViewDelegate = self;
    self.wsTableView.separatorColor = [UIColor whiteColor];
    
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
    return 48;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];

    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont boldSystemFontOfSize:16];
    label.text = @"今日新增商户数：4户";
    label.textColor = [UIColor colorWithHexString:@"#FF7D01"];
    label.backgroundColor = [UIColor clearColor];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(view).offset(21);
        make.top.equalTo(view).offset(23);
    }];

    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataSourceArrM count];
}

- (NSInteger)tableView:(WSTableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath {
    WSTableviewDataModel *dataModel = _dataSourceArrM[indexPath.row];
    return [dataModel.secondLevelArrM count] + 1;
}

- (BOOL)tableView:(WSTableView *)tableView shouldExpandSubRowsOfCellAtIndexPath:(NSIndexPath *)indexPath {
    WSTableviewDataModel *dataModel = _dataSourceArrM[indexPath.row];
    return dataModel.shouldExpandSubRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WSTableviewDataModel *dataModel = _dataSourceArrM[indexPath.row];
    DataSCell *cell =
    [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DataSCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

//    cell.statusLabel.text = dataModel.firstLevelStr;
    cell.expandable = dataModel.expandable;
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath {
    WSTableviewDataModel *dataModel = _dataSourceArrM[indexPath.row];
    
        DataSSubCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DataSSubCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.productNamelabel.text = [dataModel object_get_fromSecondLevelArrMWithIndex:indexPath.subRow];
//        cell.bottomHeightConstraint.constant = indexPath.subRow == dataModel.secondLevelArrM.count - 1 ? 0.0f : 5.0f;
        return cell;
  
}

- (CGFloat)tableView:(WSTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(WSTableView *)tableView heightForSubRowAtIndexPath:(NSIndexPath *)indexPath {
    WSTableviewDataModel *dataModel = _dataSourceArrM[indexPath.section];
    
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WSTableviewDataModel *dataModel = _dataSourceArrM[indexPath.section];
    dataModel.shouldExpandSubRows = !dataModel.shouldExpandSubRows;

}

- (void)tableView:(WSTableView *)tableView didSelectSubRowAtIndexPath:(NSIndexPath *)indexPath {
}




@end
