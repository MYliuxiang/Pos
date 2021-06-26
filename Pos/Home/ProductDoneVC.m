//
//  ProductDoneVC.m
//  Pos
//
//  Created by 刘翔 on 2021/6/22.
//

#import "ProductDoneVC.h"
#import "ProductOneCell.h"
#import "ProductTwoCell.h"


@interface ProductDoneVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *doneB;
@property (nonatomic,strong) AdressModel *adModel;

@end

@implementation ProductDoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.title = @"商品详情";
    self.bottomView.hidden = YES;
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    
    self.doneB.layer.cornerRadius = 22;
    self.doneB.layer.masksToBounds = YES;
}

#pragma  mark --------UITableView Delegete----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        static NSString *identifire = @"cellID";
        ProductOneCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ProductOneCell" owner:nil options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        return cell;
    }else{
        static NSString *identifire = @"cellID";
        ProductTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ProductTwoCell" owner:nil options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        if (self.adModel == nil) {
            cell.noAdressL.hidden = NO;
            cell.nameL.hidden = YES;
            cell.phoneL.hidden = YES;
            cell.adressL.hidden = YES;
        }else{
            cell.noAdressL.hidden = YES;
            cell.nameL.hidden = NO;
            cell.phoneL.hidden = NO;
            cell.adressL.hidden = NO;
            cell.nameL.text = self.adModel.name;
            cell.phoneL.text = self.adModel.phone;
            cell.adressL.text = [NSString stringWithFormat:@"%@%@",self.adModel.adress,self.adModel.adressDetail];
        }
        return cell;
    }
   
    
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
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        AdressVC *vc = [AdressVC new];
        vc.selectBlock = ^(AdressModel * _Nonnull model) {
            self.adModel = model;
            [self.tableView reloadData];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}

- (IBAction)doneAC:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}



@end
