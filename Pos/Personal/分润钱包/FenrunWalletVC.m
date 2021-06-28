//
//  FenrunWalletVC.m
//  Pos
//
//  Created by 李立 on 2021/6/26.
//

#import "FenrunWalletVC.h"
#import "ManagementVC.h"
#import "DirectnessVC.h"
@interface FenrunWalletVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation FenrunWalletVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"分润钱包";
    [self setUI];
}

//初始化视图
-(void)setUI{
    UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, [self ykStatusbarHeight]+12, kScreenWidth, 21)];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    titlelabel.font = [UIFont boldSystemFontOfSize:16];
    titlelabel.text = @"分润钱包";
    [self.view addSubview:titlelabel];
    
    //表视图
   self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, [self ykNavigationbarAndTopHeight], kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
   self.tableView.delegate = self;
   self.tableView.dataSource = self;
   self.tableView.bounces = NO;
   self.tableView.estimatedSectionFooterHeight = 0;
//   self.tableView.estimatedSectionHeaderHeight = 0;
   self.tableView.backgroundColor = [UIColor clearColor];
   UIView *footview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.01)];
    //表视图头视图
    UIView *headview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 173)];
    headview.backgroundColor = [UIColor colorWithHexString:@"F6F6F6"];
    //白色视图
    UIView *witheview = [[UIView alloc]initWithFrame:CGRectMake(14, 20,kScreenWidth-28, 133)];
    witheview.backgroundColor = [UIColor whiteColor];
    [headview addSubview:witheview];
    
    //金钱
    self.moneylabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 41, 220, 31)];
    self.moneylabel.textAlignment = NSTextAlignmentCenter;
    self.moneylabel.font = [UIFont boldSystemFontOfSize:28];
    self.moneylabel.textColor = [UIColor colorWithHexString:@"FF8901"];
    self.moneylabel.text = @"9098.00";
    [witheview addSubview:self.moneylabel];
    
    //可提现
    UILabel *ktxlabel = [[UILabel alloc]initWithFrame:CGRectMake(self.moneylabel.left, self.moneylabel.bottom+5, self.moneylabel.width, 19)];
    ktxlabel.textColor = [UIColor colorWithHexString:@"#BDBDBD"];
    ktxlabel.textAlignment = NSTextAlignmentCenter;
    ktxlabel.text = @"可提现";
    ktxlabel.font = [UIFont systemFontOfSize:14];
    [witheview addSubview:ktxlabel];
    
    //去提现按钮
    UIButton *txbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    txbutton.frame = CGRectMake(witheview.width-124, 49, 88, 36);
    KViewBorderRadius(txbutton, 3, 1, [UIColor colorWithHexString:@"#FF8901"]);
    [txbutton setTitleColor:[UIColor colorWithHexString:@"#FF8901"] forState:UIControlStateNormal];
    [txbutton setTitle:@"去提现" forState:UIControlStateNormal];
    txbutton.titleLabel.font = [UIFont systemFontOfSize:14];
    [txbutton addTarget:self action:@selector(txbuttonacion) forControlEvents:UIControlEventTouchUpInside];
    [witheview addSubview:txbutton];
    
    self.tableView.tableHeaderView = headview;
   self.tableView.tableFooterView = footview;
//    self.tableView.tableHeaderView = headview;
   [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
   [self.view addSubview:self.tableView];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 1;
    }else if (section ==1){
        return 2;
    }else if (section ==2){
        return 2;
    }else{
        return 1;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"JFletTableViewCell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] init];
        [cell setRestorationIdentifier:@"TransactionTableViewCell"];
    }
   
    //线条
    UIView *xtview = [[UIView alloc]initWithFrame:CGRectMake(0, 44-1, kScreenWidth, 1)];
    xtview.backgroundColor = [UIColor colorWithHexString:@"E9E9E9"];
    [cell addSubview:xtview];
    
    //箭头
    UIImageView *goinimagview = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-30, 14, 9.14, 16.26)];
    goinimagview.image = [UIImage imageNamed:@"返回(2)"];
    [cell addSubview:goinimagview];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
    if (indexPath.section ==0) {
        xtview.hidden = YES;
        UILabel *moneylabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-300, 13, 250, 19)];
        moneylabel.textAlignment = NSTextAlignmentRight;
        moneylabel.font = [UIFont systemFontOfSize:14];
        moneylabel.textColor = [UIColor colorWithHexString:@"#BDBDBD"];
        moneylabel.text = @"￥250.00";
        [cell.contentView addSubview:moneylabel];
        cell.textLabel.text = @"管理奖分润";
    }else if (indexPath.section==1){
        if (indexPath.row ==0) {
            cell.textLabel.text = @"直属商户";
        }else if (indexPath.row==1) {
            xtview.hidden = YES;
            cell.textLabel.text = @"团队商户";

        }
    }else if (indexPath.section ==2){
        UILabel *moneylabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-300, 13, 250, 19)];
        moneylabel.textAlignment = NSTextAlignmentRight;
        moneylabel.font = [UIFont systemFontOfSize:14];
        moneylabel.textColor = [UIColor colorWithHexString:@"#BDBDBD"];
        moneylabel.text = @"上月待发分润金额：¥3223.00";
        [cell.contentView addSubview:moneylabel];
        cell.textLabel.text = @"直属企业版商户";
        if (indexPath.row==1) {
            xtview.hidden = YES;
            cell.textLabel.text = @"团队企业版商户";
            moneylabel.text = @"上月待发分润金额：¥3223.00";
        }
    }else{
        xtview.hidden = YES;
        cell.textLabel.text = @"调价分成（隐藏）";
    }
    
    return cell;
}

#pragma mark -UITableView代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
// 添加每组的组头
- (UIView *)tableView:(nonnull UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    if (section ==1) {
     view.frame =CGRectMake(0, 0, kScreenWidth, 39);
    UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 13, kScreenWidth-40, 21)];
    titlelabel.font = [UIFont boldSystemFontOfSize:16];
    titlelabel.text = @"日结明细";
    [view addSubview:titlelabel];
     view.backgroundColor = [UIColor colorWithHexString:@"F6F6F6"];
    }else if (section ==2){
        view.frame =CGRectMake(0, 0, kScreenWidth, 39);
       UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 13, kScreenWidth-40, 21)];
       titlelabel.font = [UIFont boldSystemFontOfSize:16];
       titlelabel.text = @"月结明细";
       [view addSubview:titlelabel];
        view.backgroundColor = [UIColor colorWithHexString:@"F6F6F6"];
    }else{
        view.frame =CGRectMake(0, 0, kScreenWidth, 20);
    }
    return view;
 }
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section ==0) {
        return 0.01;
    }else if (section ==3){
        return 20;
    }else{
        return 39;
    }
}
#pragma mark - 列表点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section ==0) {
        //管理奖分润
        ManagementVC *vc = [[ManagementVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section ==1){
        if (indexPath.row ==0) {
        DirectnessVC *vc = [[DirectnessVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        }
    }
  
}

//可提现
-(void)txbuttonacion{
    
}
@end
