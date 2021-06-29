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
    [self loadData];
    
    self.tableView.mj_header = [LxResfreshHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)loadData{
    BADataEntity *entity1 = [BADataEntity new];
    entity1.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_address];
    entity1.needCache = NO;
    [MBProgressHUD showHUDAddedTo:lxWindow animated:YES];
    [BANetManager ba_request_GETWithEntity:entity1 successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 200){
            self.dataList = [AdressModel mj_objectArrayWithKeyValuesArray:result[@"data"]];
            [self.tableView reloadData];
        }
        [self.tableView.mj_header endRefreshing];
    } failureBlock:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];

    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}

- (IBAction)addAC:(id)sender {
    
    AddAdressVC *vc = [AddAdressVC new];
    vc.addBlock = ^() {
//        [self.dataList addObject:model];
        [self loadData];
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
    vc.addBlock = ^() {
        [self loadData];
    };
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)deletedAC:(UIButton *)btn{
    
    NSInteger index = btn.tag - 200;
    AdressModel *model = self.dataList[index];
    
    
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@%@",MainUrl,Url_address,model.aid];
    entity.needCache = NO;
   
    [MBProgressHUD showHUDAddedTo:lxWindow animated:YES];
    [BANetManager ba_request_DELETEWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 200) {
            [self.dataList removeObject:model];
            if (model.defaultValue) {
                [self loadData];
            }else{
                [self.tableView deleteSection:index withRowAnimation:UITableViewRowAnimationLeft];
            }
        }
        
    } failureBlock:^(NSError *error) {
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
    
    
    
   
    
}



- (void)defaultAC:(UIButton *)btn{
    NSInteger index = btn.tag - 300;
    AdressModel *model = self.dataList[index];
  
    if (model.defaultValue) {
        return;
    }
    
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@%@",MainUrl,Url_address,model.aid];
    entity.needCache = NO;
   
    [MBProgressHUD showHUDAddedTo:lxWindow animated:YES];
    [BANetManager ba_request_PUTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 200) {
                
            for (AdressModel *dmodel in self.dataList) {
                dmodel.defaultValue = NO;
            }
            model.defaultValue = YES;
            [self.tableView reloadData];
          
        }
        
    } failureBlock:^(NSError *error) {
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
    
    
    
    
    
       
    
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
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
    
}



@end
