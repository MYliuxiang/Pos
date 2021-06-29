//
//  MoresettingsVC.m
//  Pos
//
//  Created by 李立 on 2021/6/24.
//

#import "MoresettingsVC.h"
#import "ChangePasswordVC.h"
#import "ChangiphoneVC.h"
@interface MoresettingsVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MoresettingsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUI];
}
-(void)setUI{
    UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, [self ykStatusbarHeight]+12, kScreenWidth, 21)];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    titlelabel.font = [UIFont boldSystemFontOfSize:16];
    titlelabel.text = @"更多设置";
    [self.view addSubview:titlelabel];
    
    //表视图
   self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, [self ykNavigationbarAndTopHeight]+20, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
   self.tableView.delegate = self;
   self.tableView.dataSource = self;
   self.tableView.bounces = NO;
   self.tableView.estimatedSectionFooterHeight = 0;
   self.tableView.estimatedSectionHeaderHeight = 0;
   self.tableView.backgroundColor = [UIColor clearColor];
   UIView *footview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
        
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(46, (100 - 44) / 2, kScreenWidth - 92, 44);
    btn.backgroundColor = [UIColor colorWithHexString:@"#FF8901"];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitle:@"退出登录" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(loginOutAC) forControlEvents:UIControlEventTouchUpInside];
    [footview addSubview:btn];
    LXViewBorder(btn, 22);
    
   self.tableView.tableFooterView = footview;
   
    
    
   [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
   [self.view addSubview:self.tableView];
}

- (void)loginOutAC{
    
    [LoginManger sharedManager].currentLoginModel = nil;
    [HandleTool switchLgoinVC];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] init];
        [cell setRestorationIdentifier:@"MessageCell"];
    }
    NSArray *titlearry = @[@"修改密码",@"更换手机号",@"检查更新"];
    UIView *xtview = [[UIView alloc]initWithFrame:CGRectMake(0, 52-1, kScreenWidth, 1)];
    xtview.backgroundColor = [UIColor colorWithHexString:@"DCDCDC"];
    [cell.contentView addSubview:xtview];
    
    //箭头
    UIImageView *goinimagview = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-30, 17, 9.14, 16.26)];
    goinimagview.image = [UIImage imageNamed:@"返回(2)"];
    [cell.contentView addSubview:goinimagview];
    
    cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
    cell.textLabel.text = titlearry[indexPath.row];
    
    return cell;
}

#pragma mark -UITableView代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 52;
}

#pragma mark - 列表点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row ==0) {
        //修改密码
        ChangePasswordVC *VC = [[ChangePasswordVC alloc]init];
        [self.navigationController pushViewController:VC animated:YES];
    }else if (indexPath.row==1){
        //更换手机号
        ChangiphoneVC *VC = [[ChangiphoneVC alloc]init];
        [self.navigationController pushViewController:VC animated:YES];
    }else{
        //检查更新
    }
    
}
@end
