//
//  FaxianWalletVC.m
//  Pos
//
//  Created by 李立 on 2021/6/27.
//

#import "FaxianWalletVC.h"

@interface FaxianWalletVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation FaxianWalletVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUI];
}

//初始化视图
-(void)setUI{
    UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, [self ykStatusbarHeight]+12, kScreenWidth, 21)];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    titlelabel.font = [UIFont boldSystemFontOfSize:16];
    titlelabel.text = @"返现钱包";
    [self.view addSubview:titlelabel];
    
    //表视图
   self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, [self ykNavigationbarAndTopHeight], kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
   self.tableView.delegate = self;
   self.tableView.dataSource = self;
   self.tableView.bounces = NO;
   self.tableView.estimatedSectionFooterHeight = 0;
//   self.tableView.estimatedSectionHeaderHeight = 0;
   self.tableView.backgroundColor = [UIColor clearColor];
   UIView *footview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    
    //提示
    UILabel *tishilabel = [[UILabel alloc]initWithFrame:CGRectMake(76, 33, 80, 19)];
    tishilabel.textColor = [UIColor colorWithHexString:@"#CACACA"];
    tishilabel.text = @"提示:";
    tishilabel.font = [UIFont systemFontOfSize:14];
    [footview addSubview:tishilabel];
    
    //提示内容
    UILabel *neironglabel = [[UILabel alloc]initWithFrame:CGRectMake(tishilabel.left, tishilabel.bottom+15, 286, 100)];
    neironglabel.numberOfLines = 0;
    neironglabel.textColor = [UIColor colorWithHexString:@"#CACACA"];
    neironglabel.text = @"首次达标：N时间到N时间，达标剩余交易金额\n二次达标：N时间到N时间，达标剩余交易金额\n三次达标：N时间到N时间，达标剩余交易金额\n四次达标：N时间到N时间，达标剩余交易金额";
    neironglabel.font = [UIFont systemFontOfSize:14];
    [footview addSubview:neironglabel];
    
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section ==0) {
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
        if (indexPath.row ==0) {
            cell.textLabel.text = @"直属商户返现";
        }else if (indexPath.row ==1){
            cell.textLabel.text = @"招募奖";
        }
    }else if (indexPath.section==1){
        if (indexPath.row ==0) {
            cell.textLabel.text = @"直属商户返现";
            UILabel *moneylabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-300, 13, 250, 19)];
            moneylabel.textAlignment = NSTextAlignmentRight;
            moneylabel.font = [UIFont systemFontOfSize:14];
            moneylabel.textColor = [UIColor colorWithHexString:@"#BDBDBD"];
            moneylabel.text = @"￥250.00";
            [cell.contentView addSubview:moneylabel];
        }
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
    if (section ==0) {
     view.frame =CGRectMake(0, 0, kScreenWidth, 39);
    UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 13, kScreenWidth-40, 21)];
    titlelabel.font = [UIFont boldSystemFontOfSize:16];
    titlelabel.text = @"日结明细";
    [view addSubview:titlelabel];
     view.backgroundColor = [UIColor colorWithHexString:@"F6F6F6"];
    }else if (section ==1){
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
    
    return 39;
}
#pragma mark - 列表点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

//可提现
-(void)txbuttonacion{
    
}
@end
