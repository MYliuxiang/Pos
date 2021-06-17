//
//  HomeVC.m
//  Pos
//
//  Created by tenvine on 2021/6/16.
//

#import "HomeVC.h"
#import "HomeOneCell.h"
#import "HomeTwoCCell.h"

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
