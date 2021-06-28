//
//  DetailsfenrunVC.m
//  Pos
//
//  Created by 李立 on 2021/6/26.
//

#import "DetailsfenrunVC.h"
@interface DetailsfenrunVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation DetailsfenrunVC

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
    titlelabel.text = @"详情";
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
    self.moneylabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 41, witheview.width, 31)];
    self.moneylabel.textAlignment = NSTextAlignmentCenter;
    self.moneylabel.font = [UIFont boldSystemFontOfSize:28];
    self.moneylabel.textColor = [UIColor colorWithHexString:@"FF8901"];
    self.moneylabel.text = @"9098.00";
    [witheview addSubview:self.moneylabel];
    
    //可提现
    UILabel *ktxlabel = [[UILabel alloc]initWithFrame:CGRectMake(self.moneylabel.left, self.moneylabel.bottom+5, self.moneylabel.width, 19)];
    ktxlabel.textColor = [UIColor colorWithHexString:@"#BDBDBD"];
    ktxlabel.textAlignment = NSTextAlignmentCenter;
    ktxlabel.text = @"返现金额（元）";
    ktxlabel.font = [UIFont systemFontOfSize:14];
    [witheview addSubview:ktxlabel];
    
    self.tableView.tableHeaderView = headview;
   self.tableView.tableFooterView = footview;
//    self.tableView.tableHeaderView = headview;
   [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
   [self.view addSubview:self.tableView];
    
    self.titlearry = @[@"商户号",@"直属代理商名称",@"代理商编号",@"机身号",@"设备类型",@"注册时间",@"首次达标返现时间"];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titlearry.count;
    
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
    cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
    cell.textLabel.text = self.titlearry[indexPath.row];
    NSArray *afterarry = @[@"9098989",@"李三",@"798098769",@"789987L",@"押金和非押金（XX品牌）",@"2021.09.12 23:34:23",@"2021.09.12 23:34:23"];
    UILabel *moneylabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-300, 13, 280, 19)];
    moneylabel.textAlignment = NSTextAlignmentRight;
    moneylabel.font = [UIFont systemFontOfSize:14];
    moneylabel.textColor = [UIColor colorWithHexString:@"#BDBDBD"];
    moneylabel.text = afterarry[indexPath.row];
    [cell.contentView addSubview:moneylabel];
    
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
        
    }
  
}


@end
