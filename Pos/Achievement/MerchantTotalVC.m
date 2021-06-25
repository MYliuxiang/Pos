//
//  MerchantTotalVC.m
//  Pos
//
//  Created by tenvine on 2021/6/25.
//

#import "MerchantTotalVC.h"
#import "TradeDCell.h"
#import "TradeDSubCell.h"

@interface MerchantTotalVC ()<WSTableViewDelegate>

@property (weak, nonatomic) IBOutlet WSTableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataSourceArrM;

@end

@implementation MerchantTotalVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.title = @"商户总数";
    self.dataSourceArrM = [NSMutableArray array];
    [self registerCell];

    [self addData];

}

- (void)addData {

    self.tableView.WSTableViewDelegate = self;
    self.tableView.separatorColor = [UIColor whiteColor];

    _dataSourceArrM = [NSMutableArray array];
    WSTableviewDataModel *dataModel = [[WSTableviewDataModel alloc] init];
    dataModel.firstLevelStr = @"商户总数";
    dataModel.expandable = NO;
    [_dataSourceArrM addObject:dataModel];

    WSTableviewDataModel *dataModel1 = [[WSTableviewDataModel alloc] init];
    dataModel1.firstLevelStr = @"服务商商户总数";
    dataModel1.expandable = NO;
    [_dataSourceArrM addObject:dataModel1];

    WSTableviewDataModel *dataModel2 = [[WSTableviewDataModel alloc] init];
    dataModel2.firstLevelStr = @"XX的商户总数：98";
    dataModel2.shouldExpandSubRows = NO;
    [dataModel2 object_add_toSecondLevelArrM:@"XX1品牌"];
    [dataModel2 object_add_toSecondLevelArrM:@"直营XXX品牌商户总数"];
    [dataModel2 object_add_toSecondLevelArrM:@"直营XXX商户"];
    [_dataSourceArrM addObject:dataModel2];


}

- (void)registerCell {


    UINib *orderManagerNib = [UINib nibWithNibName:NSStringFromClass([TradeDCell class]) bundle:nil];
    [self.tableView registerNib:orderManagerNib forCellReuseIdentifier:NSStringFromClass([TradeDCell class])];

    UINib *orderProductNib = [UINib nibWithNibName:NSStringFromClass([LxSubTitleCell class]) bundle:nil];
    [self.tableView registerNib:orderProductNib forCellReuseIdentifier:NSStringFromClass([LxSubTitleCell class])];


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
    return [dataModel.secondLevelArrM count];
}

- (BOOL)tableView:(WSTableView *)tableView shouldExpandSubRowsOfCellAtIndexPath:(NSIndexPath *)indexPath {
    WSTableviewDataModel *dataModel = _dataSourceArrM[indexPath.row];
    return dataModel.shouldExpandSubRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WSTableviewDataModel *dataModel = _dataSourceArrM[indexPath.row];
    if (dataModel.expandable) {
        static NSString *identifire = @"TradeDCellID";
        TradeDCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"TradeDCell" owner:nil options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UIView *lineView = [UIView new];
            lineView.frame = CGRectMake(0, 43, kScreenWidth, 1);
            lineView.backgroundColor = [UIColor colorWithHexString:@"#DCDCDC"];
            [cell.contentView addSubview:lineView];

        }
        cell.expandable = dataModel.expandable;
        cell.timeL.text = dataModel.firstLevelStr;
        cell.timeL.textColor = [UIColor colorWithHexString:@"#FF8901"];

        return  cell;

    }else{

        static NSString *identifire = @"cellID";
        LxSubTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"LxSubTitleCell" owner:nil options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UIView *lineView = [UIView new];
            lineView.frame = CGRectMake(0, 43, kScreenWidth, 1);
            lineView.backgroundColor = [UIColor colorWithHexString:@"#DCDCDC"];
            [cell.contentView addSubview:lineView];

        }
        cell.lab1.text = dataModel.firstLevelStr;
        cell.lab1.font = [UIFont boldSystemFontOfSize:14];
        cell.lab1.textColor = [UIColor colorWithHexString:@"#232323"];

        cell.lab2.text = @"33";
        cell.lab2.textColor = [UIColor colorWithHexString:@"#BDBDBD"];

        return  cell;

    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath {
    WSTableviewDataModel *dataModel = _dataSourceArrM[indexPath.row];

    static NSString *identifire = @"scellID";
    LxSubTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LxSubTitleCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIView *lineView = [UIView new];
        lineView.frame = CGRectMake(0, 43, kScreenWidth, 1);
        lineView.backgroundColor = [UIColor colorWithHexString:@"#DCDCDC"];
        [cell.contentView addSubview:lineView];

    }
    cell.lab1.text = [dataModel object_get_fromSecondLevelArrMWithIndex:indexPath.subRow];
    cell.lab2.text = @"33";
    cell.lab1.textColor = [UIColor colorWithHexString:@"#232323"];
    cell.lab1.font = [UIFont boldSystemFontOfSize:14];

    cell.lab2.textColor = [UIColor colorWithHexString:@"#BDBDBD"];

//         cell.productNamelabel.text = [dataModel object_get_fromSecondLevelArrMWithIndex:indexPath.subRow];
//        cell.bottomHeightConstraint.constant = indexPath.subRow == dataModel.secondLevelArrM.count - 1 ? 0.0f : 5.0f;
        return cell;

}

- (CGFloat)tableView:(WSTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(WSTableView *)tableView heightForSubRowAtIndexPath:(NSIndexPath *)indexPath {
    WSTableviewDataModel *dataModel = _dataSourceArrM[indexPath.section];

    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    WSTableviewDataModel *dataModel = _dataSourceArrM[indexPath.section];
    dataModel.shouldExpandSubRows = !dataModel.shouldExpandSubRows;

}

- (void)tableView:(WSTableView *)tableView didSelectSubRowAtIndexPath:(NSIndexPath *)indexPath {
}



@end
