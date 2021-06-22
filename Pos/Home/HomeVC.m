//
//  HomeVC.m
//  Pos
//
//  Created by tenvine on 2021/6/16.
//

#import "HomeVC.h"
#import "HomeOneCell.h"
#import "HomeTwoCCell.h"
#import "DataShowVC.h"
#import "MerchantDetailVC.h"
#import "BusinessVC.h"
#import "TerminalManagerVC.h"
#import "LeranVC.h"

@interface HomeVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIButton *headerB1;
@property (weak, nonatomic) IBOutlet UIButton *headerB2;
@property (weak, nonatomic) IBOutlet UIButton *headerB3;
@property (weak, nonatomic) IBOutlet UIButton *headerB4;
@property (weak, nonatomic) IBOutlet UIButton *headerB5;
@property (weak, nonatomic) IBOutlet UIView *headerCV;
@property (weak, nonatomic) IBOutlet UIView *headerCDownV;
@property (weak, nonatomic) IBOutlet UILabel *hederTotalL;


@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.hidden = YES;
    [self setUI];
    

    self.headerView.autoresizingMask = UIViewAutoresizingNone;
    self.tableView.tableHeaderView = self.headerView;

    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;

}

- (void)setUI{
    [self.headerB1 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:9];
    [self.headerB2 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:9];
    [self.headerB3 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:9];
    [self.headerB4 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:9];
    [self.headerB5 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:9];
    
    self.headerCV.layer.cornerRadius=10;
    self.headerCV.layer.shadowColor=[UIColor blackColor].CGColor;
    self.headerCV.layer.shadowOffset=CGSizeMake(5, 5);
    self.headerCV.layer.shadowOpacity=0.3;
    self.headerCV.layer.shadowRadius=5;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerClick)];
    [self.headerCDownV addGestureRecognizer:tap];
    
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapheaderTitle)];
    self.hederTotalL.userInteractionEnabled = YES;
    [self.hederTotalL addGestureRecognizer:tap1];
    

      
}

- (void)tapheaderTitle {
    
    MerchantDetailVC *vc = [MerchantDetailVC new];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)headerBottomAC:(UIButton *)sender {
    
    NSInteger tag = sender.tag;
    switch (tag - 100) {
        case 0:
        {
            //商户登记
            
        }
            break;
        case 1:
        {
            //终端管理
            TerminalManagerVC *vc = [TerminalManagerVC new];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
            
        case 2:
        {
            //业务拓展
            BusinessVC *vc = [BusinessVC new];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
            
        case 3:
        {
            //学习讲堂
            LeranVC *vc = [LeranVC new];
            [self.navigationController pushViewController:vc animated:YES];
            
            
        }
            break;
            
        case 4:
        {
            //紧急关注
            
            
        }
            break;
            
            
        default:
            break;
    }
    
}





- (void)headerClick{
    DataShowVC *vc = [DataShowVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
  
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.headerCDownV.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = self.headerCDownV.bounds;
    maskLayer.path = maskPath.CGPath;
    self.headerCDownV.layer.mask = maskLayer;
}

#pragma  mark --------UITableView Delegete----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        static NSString *identifire = @"cellID";
        HomeOneCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"HomeOneCell" owner:nil options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        
        return cell;
    }else{
        static NSString *identifire = @"cellID2";
        HomeOneCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"HomeTwoCell" owner:nil options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        
        return cell;
    }
   
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.1;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
    
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
