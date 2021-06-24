//
//  PersonalcertificationVC.m
//  Pos
//
//  Created by 李立 on 2021/6/25.
//

#import "PersonalcertificationVC.h"

@interface PersonalcertificationVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation PersonalcertificationVC

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
    titlelabel.text = @"个人认证";
    [self.view addSubview:titlelabel];
    
    //表视图
   self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, [self ykNavigationbarAndTopHeight]+10, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
   self.tableView.delegate = self;
   self.tableView.dataSource = self;
   self.tableView.bounces = NO;
   self.tableView.estimatedSectionFooterHeight = 0;
//   self.tableView.estimatedSectionHeaderHeight = 0;
   self.tableView.backgroundColor = [UIColor clearColor];
   UIView *footview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.01)];
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
    if (section==0) {
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
    UIView *xtview = [[UIView alloc]initWithFrame:CGRectMake(22, 69-1, kScreenWidth, 1)];
    xtview.backgroundColor = [UIColor colorWithHexString:@"E9E9E9"];
    [cell addSubview:xtview];
    
  
    //显示值
    UITextField *afterlabel = [[UITextField alloc]initWithFrame:CGRectMake(kScreenWidth-200, 30, 180, 16)];
    afterlabel.textAlignment = NSTextAlignmentRight;
    afterlabel.font = [UIFont systemFontOfSize:14];
    afterlabel.textColor = [UIColor colorWithHexString:@"C4C4C4"];
    [cell addSubview:afterlabel];
    
    if (indexPath.section ==0) {
        NSArray *sectionarry = @[@"姓名",@"身份证"];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.text = sectionarry[indexPath.row];
      
        xtview.frame = CGRectMake(53, 60-1, kScreenWidth, 1);
        afterlabel.text = @"王小二";
        if (indexPath.row ==1) {
            xtview.hidden = YES;
            afterlabel.text = @"6109900098778909098";
        }
    }else if (indexPath.section ==1){
        xtview.hidden = YES;
        afterlabel.hidden = YES;
    }
    
    return cell;
}

#pragma mark -UITableView代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section ==0) {
        
      return 60;
        
    }
    return 160;
}
// 添加每组的组头
- (UIView *)tableView:(nonnull UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.frame =CGRectMake(0, 0, kScreenWidth, 46);
   UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(21, 20, kScreenWidth-40, 19)];
   titlelabel.font = [UIFont boldSystemFontOfSize:16];
   
   [view addSubview:titlelabel];
    view.backgroundColor = [UIColor colorWithHexString:@"F6F6F6"];
    if (section ==0) {
        titlelabel.text = @"个人信息";
    }else{
        titlelabel.text = @"身份证";
    }
    return view;
 }
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
   
        return 50;
    
}
#pragma mark - 列表点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
   
  
}


@end
