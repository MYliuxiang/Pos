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

@end

@implementation TradeDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.title = @"交易明细";
    
    self.dataSourceArrM = [NSMutableArray array];
    
    [self registerCell];
    [self addData];

 }

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
//    {
//        CGFloat height = [self.tableView.tableFooterView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
//        CGRect footerFrame = self.tableView.tableFooterView.frame;
//        footerFrame.size.height = height;
//        self.tableView.tableFooterView.frame = footerFrame;
//        self.tableView.tableFooterView = self.tableView.tableFooterView;
//    }
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

 - (void)addData {
     
     self.tableView.WSTableViewDelegate = self;
     self.tableView.separatorColor = [UIColor whiteColor];
     
     _dataSourceArrM = [NSMutableArray array];
     WSTableviewDataModel *dataModel = [[WSTableviewDataModel alloc] init];
     dataModel.firstLevelStr = @"2021-02";
     dataModel.shouldExpandSubRows = NO;
     [dataModel object_add_toSecondLevelArrM:@"医院1"];
     [dataModel object_add_toSecondLevelArrM:@"医院2"];
     [_dataSourceArrM addObject:dataModel];
     
     WSTableviewDataModel *dataModel2 = [[WSTableviewDataModel alloc] init];
     dataModel2.firstLevelStr = @"2021-03";
     //dataModel2.shouldExpandSubRows = YES;
     [dataModel2 object_add_toSecondLevelArrM:@"腿"];
     [dataModel2 object_add_toSecondLevelArrM:@"脚"];
     [_dataSourceArrM addObject:dataModel2];
     
     for (int i = 0; i < 20; i++) {
         WSTableviewDataModel *dataModel3 = [[WSTableviewDataModel alloc] init];
         dataModel3.firstLevelStr = @"2021-04";
         [dataModel3 object_add_toSecondLevelArrM:@"腿2"];
         dataModel3.expandable = YES;
         [_dataSourceArrM addObject:dataModel3];
     }
   
     
    
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
     return 1;
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
     TradeDCell *cell =
     [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TradeDCell class])];
     cell.selectionStyle = UITableViewCellSelectionStyleNone;

     
 //    cell.statusLabel.text = dataModel.firstLevelStr;
     cell.expandable = dataModel.expandable;
     cell.expanded = YES;
     cell.timeL.text = dataModel.firstLevelStr;
     return cell;
 }

 - (UITableViewCell *)tableView:(UITableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath {
     WSTableviewDataModel *dataModel = _dataSourceArrM[indexPath.row];
     
         TradeDSubCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TradeDSubCell class])];
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
//         cell.productNamelabel.text = [dataModel object_get_fromSecondLevelArrMWithIndex:indexPath.subRow];
 //        cell.bottomHeightConstraint.constant = indexPath.subRow == dataModel.secondLevelArrM.count - 1 ? 0.0f : 5.0f;
         return cell;
   
 }

 - (CGFloat)tableView:(WSTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
     return 76;
 }

 - (CGFloat)tableView:(WSTableView *)tableView heightForSubRowAtIndexPath:(NSIndexPath *)indexPath {
     WSTableviewDataModel *dataModel = _dataSourceArrM[indexPath.section];
     
     return 56;
 }

 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     
     WSTableviewDataModel *dataModel = _dataSourceArrM[indexPath.section];
     dataModel.shouldExpandSubRows = !dataModel.shouldExpandSubRows;

 }

 - (void)tableView:(WSTableView *)tableView didSelectSubRowAtIndexPath:(NSIndexPath *)indexPath {
 }




@end
