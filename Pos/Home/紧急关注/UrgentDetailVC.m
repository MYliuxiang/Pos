//
//  UrgentDetailVC.m
//  Pos
//
//  Created by tenvine on 2021/6/23.
//

#import "UrgentDetailVC.h"

@interface UrgentDetailVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,copy) NSArray *titles;
@property (nonatomic,copy) NSArray *values;
@end

@implementation UrgentDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.title = @"详情";
    self.titles = @[@"品牌",@"设备SN号",@"入库时间",@"截止到期时间",@"机器数量"];
    self.values = @[@"XX品牌",@"78980980",@"2021-09-23",@"2021-09-23",@"12台"];
    self.bottomView.hidden = YES;
    
}

#pragma  mark --------UITableView Delegete----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifire = @"cellID";
    LxSubTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LxSubTitleCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIView *lineView = [UIView new];
        lineView.frame = CGRectMake(0, 51, kScreenWidth, 1);
        lineView.backgroundColor = [UIColor colorWithHexString:@"#DCDCDC"];
        [cell.contentView addSubview:lineView];
        
    }
    
    cell.lab1.textColor = [UIColor colorWithHexString:@"#282828"];
    cell.lab2.textColor = [UIColor colorWithHexString:@"#BDBDBD"];

    
    cell.lab1.text = self.titles[indexPath.row];
    cell.lab2.text = self.values[indexPath.row];
    
    
    
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 10;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
    
}
- (UIView *)tableView:(UITableView *)tableView viewFooterInSection:(NSInteger)section
{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 52;
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
