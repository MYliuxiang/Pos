//
//  MessagecenterVC.m
//  Pos
//
//  Created by 李立 on 2021/6/24.
//

#import "MessagecenterVC.h"
#import "MessageCell.h"
#import "MessageNewsVC.h"
@interface MessagecenterVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MessagecenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //初始化视图
    [self setUI];
}
-(void)setUI{
    UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, [self ykStatusbarHeight]+12, kScreenWidth, 21)];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    titlelabel.font = [UIFont boldSystemFontOfSize:16];
    titlelabel.text = @"消息中心";
    [self.view addSubview:titlelabel];
    
    //清空消息
    UIButton *qkbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    qkbutton.frame = CGRectMake(kScreenWidth-84, [self ykStatusbarHeight]+14, 66, 19);
    qkbutton.titleLabel.font = [UIFont systemFontOfSize:14];
    [qkbutton setTitleColor:[UIColor colorWithHexString:@"BDBDBD"] forState:UIControlStateNormal];
    [qkbutton setTitle:@"清空消息" forState:UIControlStateNormal];
    [self.view addSubview:qkbutton];
    
    //表视图
   self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, [self ykNavigationbarAndTopHeight]+20, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
   self.tableView.delegate = self;
   self.tableView.dataSource = self;
   self.tableView.bounces = NO;
   self.tableView.estimatedSectionFooterHeight = 0;
   self.tableView.estimatedSectionHeaderHeight = 0;
   self.tableView.backgroundColor = [UIColor clearColor];
   UIView *footview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.01)];
   self.tableView.tableFooterView = footview;
//    self.tableView.tableHeaderView = headview;
   [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
   [self.view addSubview:self.tableView];
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MessageCell *cell=[tableView dequeueReusableCellWithIdentifier:@"MessageCell"];
    if (cell==nil) {
        cell=[[MessageCell alloc] init];
        [cell setRestorationIdentifier:@"MessageCell"];
    }
    return cell;
}

#pragma mark -UITableView代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 101;
}

#pragma mark - 列表点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MessageNewsVC *vc = [[MessageNewsVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
