//
//  TerminalSDetailVC.m
//  Pos
//
//  Created by tenvine on 2021/6/24.
//

#import "TerminalSDetailVC.h"

@interface TerminalSDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (copy, nonatomic) NSArray *titles;
@property (copy, nonatomic) NSArray *values;



@end

@implementation TerminalSDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.title = @"查询详情";
    self.rightImageName = @"搜索";

    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    
    self.titles = @[@"终端编号",@"返现到期",@"划拨人",@"绑定状态",@"首次达标",@"二次达标"];
    self.values = @[@"8980989",@"2021-02-23",@"李二",@"已绑定",@"150.00",@"150.00"];


}

- (void)doRightNavBarRightBtnAction{
    //搜索
}

#pragma  mark --------UITableView Delegete----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifire = @"cellID";
    LxSubTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LxSubTitleCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#DCDCDC"];
        [cell.contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(cell.contentView);
            make.bottom.equalTo(cell.contentView);
            make.height.mas_equalTo(1);
        }];
        
    }
    
    cell.lab1.textColor = [UIColor colorWithHexString:@"#282828"];
    cell.lab2.textColor = [UIColor colorWithHexString:@"#C4C4C4"];

    cell.lab1.text = self.titles[indexPath.row];
    cell.lab2.text = self.values[indexPath.row];
    
    
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.1;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 76;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, 16, 120, 44);
    btn.backgroundColor = [UIColor whiteColor];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitle:@"累计交易额" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithHexString:@"#FF8901"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(transfAC) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];

    KViewBorderRadius(btn, 10, 1, [UIColor colorWithHexString:@"#D8D8D8"]);
    

    return view;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 53;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    
}

- (void)transfAC{
    //累积交易
    MerchantDetailVC *vc = [MerchantDetailVC new];
    vc.customNavBar.title = @"累积交易";
    [self.navigationController pushViewController:vc animated:YES];
}



@end
