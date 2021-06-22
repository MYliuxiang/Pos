//
//  TerminalSingleDoneVC.m
//  Pos
//
//  Created by 刘翔 on 2021/6/23.
//

#import "TerminalSingleDoneVC.h"
#import "ChooseAgentVC.h"
#import "AgentCell.h"

@interface TerminalSingleDoneVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *bottomL;
@property (weak, nonatomic) IBOutlet UIButton *doneB;
@end

@implementation TerminalSingleDoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.title = @"终端划拨";
    self.doneB.layer.cornerRadius = 22;
    self.doneB.layer.masksToBounds = YES;
}

- (IBAction)doneAC:(id)sender {
    
    [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
}


#pragma  mark --------UITableView Delegete----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        static NSString *identifire = @"cellID";
        AgentCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"AgentCell" owner:nil options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.tipL.text = @"选择终端接收代理商";
        cell.tipL.hidden = NO;
        cell.accessoryImg.hidden = NO;
        cell.nameL.hidden = YES;
        cell.numberL.hidden = YES;
        
        return cell;
    }else{
        static NSString *identifire = @"cellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifire];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        cell.textLabel.text = @"998080000090";
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#656565"];
        return cell;
    }

    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 10;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    return view;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 40;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];

    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont boldSystemFontOfSize:14];
    label.text = @"合计：50台";
    label.textColor = [UIColor colorWithHexString:@"#4D4D4D"];
    label.backgroundColor = [UIColor clearColor];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(view);
        make.left.equalTo(view).offset(20);
    }];
    
    return view;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) return 80;

    return 30;
       
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        ChooseAgentVC *vc = [ChooseAgentVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
    
}




@end
