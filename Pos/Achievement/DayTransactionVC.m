//
//  DayTransactionVC.m
//  Pos
//
//  Created by tenvine on 2021/6/25.
//

#import "DayTransactionVC.h"

@interface DayTransactionVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,copy) NSArray *titles;

@end

@implementation DayTransactionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.title = @"当日总交易额";
    self.titles = @[@"当日XX1品牌总交易额",@"当日XX2品牌总交易额",@"当日XX3品牌总交易额"];

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
        UIView *lineView = [UIView new];
        lineView.frame = CGRectMake(0, 61, kScreenWidth, 1);
        lineView.backgroundColor = [UIColor colorWithHexString:@"#DCDCDC"];
        [cell.contentView addSubview:lineView];
        
    }
    cell.lab1.text = self.titles[indexPath.row];
    cell.lab1.textColor = [UIColor colorWithHexString:@"#232323"];
    cell.lab1.font = [UIFont boldSystemFontOfSize:14];

    cell.lab2.text = @"33";
    cell.lab2.textColor = [UIColor colorWithHexString:@"#BDBDBD"];

    
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 44;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];

    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont boldSystemFontOfSize:14];
    label.text = @"当日总交易额";
    label.textColor = [UIColor colorWithHexString:@"#FF8901"];
    label.backgroundColor = [UIColor clearColor];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(20);
        make.top.bottom.equalTo(view);
    }];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.font = [UIFont systemFontOfSize:14];
    label1.text = @"275";
    label1.textColor = [UIColor colorWithHexString:@"#BDBDBD"];
    label1.backgroundColor = [UIColor clearColor];
    [view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view).offset(-20);
        make.top.bottom.equalTo(view);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#DCDCDC"];
    [view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(view);
        make.bottom.equalTo(view);
        make.height.mas_equalTo(1);
    }];
    
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 62;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
