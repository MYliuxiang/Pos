//
//  MybankcardVC.m
//  Pos
//
//  Created by 李立 on 2021/6/27.
//

#import "MybankcardVC.h"
#import "MybankCell.h"
#import "AddCarVC.h"
@interface MybankcardVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MybankcardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUI];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];
}

//初始化视图
-(void)setUI{
    UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, [self ykStatusbarHeight]+12, kScreenWidth, 21)];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    titlelabel.font = [UIFont boldSystemFontOfSize:16];
    titlelabel.text = @"我的银行卡";
    [self.view addSubview:titlelabel];
    
    //表视图
   self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, [self ykNavigationbarAndTopHeight], kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
   self.tableView.delegate = self;
   self.tableView.dataSource = self;
   self.tableView.bounces = NO;
   self.tableView.estimatedSectionFooterHeight = 0;
//   self.tableView.estimatedSectionHeaderHeight = 0;
   self.tableView.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];
   UIView *footview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.01)];
   self.tableView.tableFooterView = footview;
//    self.tableView.tableHeaderView = headview;
   [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
   [self.view addSubview:self.tableView];
    
    //新增按钮
    UIButton *xinzengbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    xinzengbutton.frame = CGRectMake((kScreenWidth-335)/2, kScreenHeight-85, 335, 44);
    KViewBorderRadius(xinzengbutton, 22, 0.5, [UIColor clearColor]);
    xinzengbutton.backgroundColor = [UIColor colorWithHexString:@"#FF8901"];
    [xinzengbutton setTitle:@"新增" forState:UIControlStateNormal];
    [xinzengbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [xinzengbutton addTarget:self action:@selector(xinzengbuttonaciton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:xinzengbutton];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MybankCell *cell=[tableView dequeueReusableCellWithIdentifier:@"MybankCell"];
    if (cell==nil) {
        cell=[[MybankCell alloc] init];
        [cell setRestorationIdentifier:@"MybankCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];
    return cell;
}

#pragma mark -UITableView代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 158;
}

#pragma mark - 列表点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

//新增按钮
-(void)xinzengbuttonaciton{
    AddCarVC *vc = [[AddCarVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
