//
//  AdressVC.m
//  Pos
//
//  Created by 刘翔 on 2021/6/27.
//

#import "AdressVC.h"
#import "AdressCell.h"
#import "AddAdressVC.h"

@interface AdressVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *addB;
@property(strong,nonatomic) NSMutableArray *dataList;
@end

@implementation AdressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if(self.selectBlock == nil){
        self.customNavBar.title = @"管理收货地址";
    }else{
        self.customNavBar.title = @"选择收货地址";

    }
    self.dataList = [NSMutableArray array];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    
    LXViewBorder(self.addB, 22);
    
    for (int i = 0; i < 3; i++) {
        AdressModel *model = [[AdressModel alloc] init];
        if (i == 2) {
            model.name = @"翔哥";
            model.isDefalut = YES;
        }else if (i == 1){
            model.name = @"小丽丽";
            model.isDefalut = NO;
        }else{
            model.name = @"小花花";
            model.isDefalut = NO;
        }
        model.phone = @"13823252392";
        model.adress = @"广东省深圳市南山区";
        model.adressDetail = @"南山大道山红叶小区";
        [self.dataList addObject:model];
    }
}

- (IBAction)addAC:(id)sender {
    
    AddAdressVC *vc = [AddAdressVC new];
    vc.addBlock = ^(AdressModel * _Nonnull model) {
        [self.dataList addObject:model];
        [self.tableView reloadData];
    };
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma  mark --------UITableView Delegete----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifire = @"cellID";
    AdressCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AdressCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    cell.model = self.dataList[indexPath.section];
    cell.editB.tag = 100 + indexPath.section;
    [cell.editB addTarget:self action:@selector(editAC:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.deletedB.tag = 200 + indexPath.section;
    [cell.deletedB addTarget:self action:@selector(deletedAC:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.defaultB.tag = 300 + indexPath.section;
    [cell.defaultB addTarget:self action:@selector(defaultAC:) forControlEvents:UIControlEventTouchUpInside];
        
    return cell;
    
}

- (void)editAC:(UIButton *)btn{
    
    NSInteger index = btn.tag - 100;
    AdressModel *smodel = self.dataList[index];
    AddAdressVC *vc = [AddAdressVC new];
    vc.model = smodel;
    vc.addBlock = ^(AdressModel * _Nonnull model) {
        [self.dataList replaceObjectAtIndex:index withObject:model];
        [self.tableView reloadData];
    };
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)deletedAC:(UIButton *)btn{
    
    NSInteger index = btn.tag - 200;
    AdressModel *model = self.dataList[index];
    [self.dataList removeObject:model];
    if (model.isDefalut) {
        if (self.dataList.count > 0) {
            AdressModel *defaultM = self.dataList[0];
            defaultM.isDefalut = YES;
        }
    }
    
    [self.tableView reloadData];
    
}



- (void)defaultAC:(UIButton *)btn{
    NSInteger index = btn.tag - 300;
    AdressModel *model = self.dataList[index];
    if (!model.isDefalut) {
        for (AdressModel *dmodel in self.dataList) {
            dmodel.isDefalut = NO;
        }
        model.isDefalut = YES;

        [self.tableView reloadData];
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
    return 0.1;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    
    return view;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AdressModel *model = self.dataList[indexPath.section];
    if (self.selectBlock) {
        self.selectBlock(model);
    }
    
    
}



@end
