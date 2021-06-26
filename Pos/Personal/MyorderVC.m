//
//  MyorderVC.m
//  Pos
//
//  Created by 李立 on 2021/6/26.
//

#import "MyorderVC.h"
#import "MyoerderCellTableViewCell.h"
@interface MyorderVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MyorderVC

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
    titlelabel.text = @"我的订单";
    [self.view addSubview:titlelabel];
    
    //表视图
   self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, [self ykNavigationbarAndTopHeight]+20, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
        return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyoerderCellTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"MyoerderCellTableViewCell"];
    if (cell==nil) {
        cell=[[MyoerderCellTableViewCell alloc] init];
        [cell setRestorationIdentifier:@"MyoerderCellTableViewCell"];
    }
    cell.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    
    return cell;
}

#pragma mark -UITableView代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 235;
}

#pragma mark - 列表点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
   
  
}


@end
