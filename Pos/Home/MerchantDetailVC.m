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
@property (nonatomic,strong) NSArray *dataList;


@property (weak, nonatomic) IBOutlet UIButton *headerB;

@end

@implementation MerchantDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.title = @"数据展示";
    
    [self.headerB layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
    self.headerView.height = 197;
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    
    self.nameList = @[@"姓名",@"手机号",@"商户类型",@"机器编码",@"登记时间"];
    self.subList = @[@"王晓热",@"13278990099",@"多宝宝",@"7897668988989",@"2021-09-12  12:23:23"];
    self.dataList = @[@"首次达标：N时间到N时间，达标剩余金额￥7000",@"二次达标：N时间到N时间，达标剩余金额￥7000",@"三次达标：N时间到N时间，达标剩余金额￥7000",
        @"四次达标：N时间到N时间，达标剩余金额￥7000"];

}

- (IBAction)headeClickAC:(id)sender {
    NSLog(@"点击了头部");
}

#pragma  mark --------UITableView Delegete----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
       
        return self.nameList.count;

    }
    return  self.dataList.count;
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
       
        cell.detailTextLabel.text = self.subList[indexPath.row];
        cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:14];
        cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"#B3B3B3"];
        cell.backgroundColor = [UIColor whiteColor];
    }else{
        cell.textLabel.text = self.dataList[indexPath.row];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#282828"];
        cell.detailTextLabel.text = @"";
        cell.backgroundColor = Color_bg;
        
        
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
