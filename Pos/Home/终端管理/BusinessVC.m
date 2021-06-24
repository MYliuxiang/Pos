//
//  BusinessVC.m
//  Pos
//
//  Created by tenvine on 2021/6/22.
//

#import "BusinessVC.h"
#import "BusinessCell.h"
#import "InvitationVC.h"
#import "ToFaceVC.h"

@interface BusinessVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation BusinessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.title = @"业务拓展";
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;

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
    
    static NSString *identifire = @"cellID";
    BusinessCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BusinessCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    if (indexPath.row == 0) {
        cell.img.image = [UIImage imageNamed:@"邀请"];
        cell.titleL.text = @"邀请加入";
    }else{
        cell.img.image = [UIImage imageNamed:@"组 10"];
        cell.titleL.text = @"面对面开通账号";
    }
    
    return cell;
    
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
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    return view;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        InvitationVC *vc = [InvitationVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        
        ToFaceVC *vc = [ToFaceVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}





@end
