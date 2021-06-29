//
//  MerchantSubVC.m
//  Pos
//
//  Created by 刘翔 on 2021/6/23.
//

#import "MerchantSubVC.h"
#import "MerchantCell.h"
#import "BusinessListVC.h"

@interface MerchantSubVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (copy, nonatomic) NSArray *titles;
@property (copy, nonatomic) NSArray *imageStrs;
@property (copy, nonatomic) NSArray *subTitles;
@property (nonatomic,strong) NSMutableArray *values;


@end

@implementation MerchantSubVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.hidden = YES;
    self.values = [NSMutableArray array];
    self.titles = @[@"全部商户",@"优质商户",@"活跃商户",@"休眠商户"];
    self.imageStrs = @[@"组 23",@"组 24",@"组 25",@"组 26"];
    self.subTitles = @[@"我发展的所有商户",@"我发展的优质商户",@"我发展的活跃商户",@"我发展的休眠商户"];
    self.tableView.mj_header = [LxResfreshHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
    [self.tableView.mj_header beginRefreshing];
    
    
    

}

- (void)loadData{
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_merc_reg];
    
    entity.needCache = NO;
    entity.parameters = @{@"brandId":self.model.did};
    [BANetManager ba_request_GETWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 200) {
            
            [self.values removeAllObjects];
            [self.values addObject:[NSString stringWithFormat:@"%@",result[@"data"][@"all"]]];
            [self.values addObject:[NSString stringWithFormat:@"%@",result[@"data"][@"quality"]]];
            [self.values addObject:[NSString stringWithFormat:@"%@",result[@"data"][@"active"]]];
            [self.values addObject:[NSString stringWithFormat:@"%@",result[@"data"][@"unActive"]]];

            
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
          
        }else{
            
            [self.tableView.mj_header endRefreshing];

        }
        
    } failureBlock:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];

        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
    
}


#pragma  mark --------UITableView Delegete----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return self.values.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifire = @"cellID";
    MerchantCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MerchantCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    cell.titleL.text = self.titles[indexPath.row];
    cell.subTitleL.text = self.subTitles[indexPath.row];
    cell.img.image = [UIImage imageNamed:self.imageStrs[indexPath.row]];
    cell.countL.text = self.values[indexPath.row];
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
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    
    return view;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 123;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BusinessListVC *vc = [BusinessListVC new];
    NSString *type;
    if (indexPath.row == 0) {
        type = @"all";
    }else if (indexPath.row == 1){
        type = @"quality";
    }else if (indexPath.row == 2){
        type = @"active";
    }else{
        type = @"unActive";
    }
    vc.model = self.model;
    [self.navigationController pushViewController:vc animated:YES];
    
}





#pragma mark - JXCategoryListContentViewDelegate

/**
 实现 <JXCategoryListContentViewDelegate> 协议方法，返回该视图控制器所拥有的「视图」
 */
- (UIView *)listView {
    return self.view;
}


@end
