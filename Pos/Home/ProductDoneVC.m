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
        [cell.img sd_setImageWithURL:[NSURL URLWithString:self.smodel.indexImg]];
        cell.nameL.text = self.smodel.name;
        return cell;
        
    }else{
        static NSString *identifire = @"cellID";
        ProductTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ProductTwoCell" owner:nil options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        if (self.amodel == nil) {
            cell.noAdressL.hidden = NO;
            cell.nameL.hidden = YES;
            cell.phoneL.hidden = YES;
            cell.adressL.hidden = YES;
        }else{
            cell.noAdressL.hidden = YES;
            cell.nameL.hidden = NO;
            cell.phoneL.hidden = NO;
            cell.adressL.hidden = NO;
            cell.nameL.text = self.amodel.name;
            cell.phoneL.text = self.amodel.phone;
            cell.adressL.text = [NSString stringWithFormat:@"%@%@%@%@",self.amodel.procName,self.amodel.cityName,self.amodel.districtName,self.amodel.addrDetail];
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
            self.amodel = model;
            [self.tableView reloadData];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}

- (IBAction)doneAC:(id)sender {
    
    if (self.amodel == nil) {
        [MBProgressHUD showError:@"请选择收货地址！" toView:self.view];
        return;
    }
    
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_shop_createOrder];
    entity.needCache = NO;
    entity.parameters = @{@"addressId":self.amodel.aid,@"itemId":self.smodel.sid,@"num":@"1"};
    [MBProgressHUD showHUDAddedTo:lxWindow animated:YES];
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 200){
            
            [MBProgressHUD showSuccess:@"创建订单成功！" toView:self.view];
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }
    } failureBlock:^(NSError *error) {

    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
}



@end
