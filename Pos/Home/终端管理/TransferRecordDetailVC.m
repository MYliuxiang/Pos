//
//  TransferRecordDetailVC.m
//  Pos
//
//  Created by tenvine on 2021/6/25.
//

#import "TransferRecordDetailVC.h"

@interface TransferRecordDetailVC ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,copy) NSArray *titles;
@property (nonatomic,copy) NSArray *values;

@end

@implementation TransferRecordDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.title = @"调拨记录";
    self.titles = @[@"调拨人",@"接收人",@"终端数量",@"调拨时间",@"调拨类型",@"调拨状态",@"品牌"];
    self.values = @[@"本人",@"李小二",@"8台",@"2021.09.23  23:23:45",@"逐个调拨",@"调拨成功",@"XXX品牌"];
}

#pragma  mark --------UITableView Delegete----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.titles.count;

    }else{
        return 20;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *identifire = @"cellID";
        LxSubTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"LxSubTitleCell" owner:nil options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UIView *lineView = [UIView new];
            lineView.frame = CGRectMake(0, 66, kScreenWidth, 1);
            lineView.backgroundColor = [UIColor colorWithHexString:@"#DCDCDC"];
            [cell.contentView addSubview:lineView];
        }
        cell.lab1.textColor = [UIColor colorWithHexString:@"#4D4D4D"];
        cell.lab1.font = [UIFont boldSystemFontOfSize:14];
        cell.lab2.textColor = [UIColor colorWithHexString:@"#656565"];

        
        cell.lab1.text = self.titles[indexPath.row];
        cell.lab2.text = self.values[indexPath.row];
        
        return cell;
    }else{
        
        static NSString *identifire = @"celloID";
        LxSubTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"LxSubTitleCell" owner:nil options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
           
        }
        cell.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];
        cell.lab1.textColor = [UIColor colorWithHexString:@"#656565"];
        cell.leftConstrint.constant = 40;
        cell.lab1.font = [UIFont systemFontOfSize:14];
        cell.lab2.hidden = YES;

        cell.lab1.text = @"998080000090";
        
      
        return cell;
        
    }
    
   
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    }
    return 44;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (section == 0) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor clearColor];
        return view;
        
    }
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];

    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont boldSystemFontOfSize:14];
    label.text = @"终端编号";
    label.textColor = [UIColor colorWithHexString:@"#4D4D4D"];
    label.backgroundColor = [UIColor clearColor];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(20);
        make.top.bottom.equalTo(view);
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
    if (indexPath.section == 0) {
        return 67;

    }
   
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}



@end
