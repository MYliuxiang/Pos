//
//  MerchantDetailVC.m
//  Pos
//
//  Created by 刘翔 on 2021/6/19.
//

#import "MerchantDetailVC.h"

@interface MerchantDetailVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (nonatomic,strong) NSArray *nameList;
@property (nonatomic,strong) NSArray *subList;
@property (weak, nonatomic) IBOutlet UILabel *numberL;

@property (strong, nonatomic) MerchDetailModel *detailModel;
@property (weak, nonatomic) IBOutlet UIButton *headerB;

@end

@implementation MerchantDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.title = @"商户详情";
    
    
//    self.headerB
    
    
    [self.headerB layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
 
    
    self.nameList = @[@"姓名",@"手机号",@"商户类型",@"机器编码",@"登记时间"];
    self.subList = @[@"王晓热",@"13278990099",@"多宝宝",@"7897668988989",@"2021-09-12  12:23:23"];
//    self.dataList = @[@"首次达标：N时间到N时间，达标剩余金额￥7000",@"二次达标：N时间到N时间，达标剩余金额￥7000",@"三次达标：N时间到N时间，达标剩余金额￥7000",
//        @"四次达标：N时间到N时间，达标剩余金额￥7000"];
    [self loadData];

}

- (void)loadData{
    BADataEntity *entity = [BADataEntity new];
    
    entity.urlString = [NSString stringWithFormat:@"%@%@%@",MainUrl,Url_merc_mercInfo,self.mmodel.mercId];
    entity.needCache = NO;
    entity.parameters = @{@"deviceNo":self.mmodel.deviceNo};
    [BANetManager ba_request_GETWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 200) {
            
            self.detailModel = [MerchDetailModel mj_objectWithKeyValues:result[@"data"]];
            self.headerView.height = 197;
            self.tableView.tableHeaderView = self.headerView;
            self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
            
            self.numberL.text = [NSString stringWithFormat:@"%.2f",self.detailModel.tradingMoneySum];
            
            [self.tableView reloadData];
          
        }
        
    } failureBlock:^(NSError *error) {
      

        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
    
}



- (IBAction)detailAC:(id)sender {
    TradeDetailVC *vc = [TradeDetailVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)headeClickAC:(id)sender {
    NSLog(@"点击了头部");
}

#pragma  mark --------UITableView Delegete----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.detailModel) {
        return 2;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
       
        return self.nameList.count;

    }
    return  self.detailModel.tradingDataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifire = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifire];;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
    }
    
    if (indexPath.section == 0) {
        cell.textLabel.text = self.nameList[indexPath.row];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#282828"];
       
        cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:14];
        cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"#B3B3B3"];
        cell.backgroundColor = [UIColor whiteColor];
        
        if (indexPath.row == 0) {
            cell.detailTextLabel.text = self.detailModel.name;

        }else if (indexPath.row == 1){
            cell.detailTextLabel.text = self.detailModel.phone;

        }else if (indexPath.row == 2){
            cell.detailTextLabel.text = self.detailModel.typeName;

        }else if (indexPath.row == 3){
            cell.detailTextLabel.text = self.detailModel.deviceNo;

        }else{
            cell.detailTextLabel.text = self.detailModel.registration;

        }

        
    }else{
//        cell.textLabel.text = self.dataList[indexPath.row];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#282828"];
        cell.detailTextLabel.text = @"";
        cell.backgroundColor = Color_bg;
        
        TradingModel *model = self.detailModel.tradingDataList[indexPath.row];
        if(indexPath.row == 0){
            cell.textLabel.text = [NSString stringWithFormat:@"首次达标：%@到%@，达标剩余金额￥%@",model.startTime,model.endTime,model.money];
        }else if (indexPath.row == 1){
            cell.textLabel.text = [NSString stringWithFormat:@"二次达标：%@到%@，达标剩余金额￥%@",model.startTime,model.endTime,model.money];

        }else if (indexPath.row == 2){
            cell.textLabel.text = [NSString stringWithFormat:@"三次达标：%@到%@，达标剩余金额￥%@",model.startTime,model.endTime,model.money];

        }else{
            cell.textLabel.text = [NSString stringWithFormat:@"四次达标：%@到%@，达标剩余金额￥%@",model.startTime,model.endTime,model.money];
        }
        
    }
        
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 10;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    view.backgroundColor = Color_bg;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 54;
    }
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}




@end
