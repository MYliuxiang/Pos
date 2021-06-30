//
//  AchDetailSubVC.m
//  Pos
//
//  Created by tenvine on 2021/6/24.
//

#import "AchDetailSubVC.h"
#import "ALeftCell.h"
#import "ARightCell.h"
#import "ServiceVC.h"
#import "MerchantTotalVC.h"
#import "DayTransactionVC.h"
#import "DayTotalProfitVC.h"

@interface AchDetailSubVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *dataList;
@property (nonatomic,assign) BOOL isSelected;
@property (weak, nonatomic) IBOutlet UITableView *leftTable;
@property (weak, nonatomic) IBOutlet UITableView *rightTable;

@property (copy,nonatomic) NSArray *rightTitles;
@property (nonatomic,strong) AgentModel *agentModel;


@end

@implementation AchDetailSubVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.hidden = YES;
    self.bottomView.hidden = YES;
    if (self.type == 0) {
        self.rightTitles = @[@"服务商总数",@"商户总数",@"当日总交易额",@"当日总收益额"];

    }else{
        self.rightTitles = @[@"服务商总数",@"商户总数",@"当月总交易额",@"当月总收益额"];

    }

    
    self.dataList = [NSMutableArray array];
    self.isSelected = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.leftTable selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
        if (self.agents.count > 0) {
            self.agentModel = self.agents[0];
            [self loadDataWithAgent:self.agents[0]];
        }
    });
    

//    // 初始化表格视图
//    [self initTableView];
    
}

- (void)loadDataWithAgent:(AgentModel *)agentModel{
    
    BADataEntity *entity = [BADataEntity new];
    NSString *url;
    if (self.type == 0) {
        url = Url_proxyResults_serviceList;
    }else{
        url = Url_proxyResults_serviceListMonth;
    }
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,url];
    entity.needCache = NO;
    entity.parameters = @{@"id":agentModel.aid};
    [MBProgressHUD showHUDAddedTo:lxMbProgressView animated:YES];
    [BANetManager ba_request_GETWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 200) {
            self.dataList = [AgentDataModel mj_objectArrayWithKeyValuesArray:result[@"data"]];
            [self.rightTable reloadData];
        }
                
    } failureBlock:^(NSError *error) {
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];

}

static NSString *const resueIdleft = @"leftCell";
static NSString *const resueIdright = @"rightCell";
- (void)initTableView {
    

//    self.leftTable [registerNib: forCellReuseIdentifier:resueIdleft];
    [self.leftTable registerNib:[UINib nibWithNibName:@"ALeftCell" bundle:nil] forCellReuseIdentifier:resueIdleft];

    [self.rightTable registerNib:[UINib nibWithNibName:@"ARightCell" bundle:nil] forCellReuseIdentifier:resueIdright];
}




#pragma mark - 直接刷新
#pragma mark ~~~~~~~~~~ TableViewDataSource ~~~~~~~~~~

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.leftTable) {
        return 1;
    }
    return self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.leftTable) {
        return self.agents.count;
    }
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (tableView == self.leftTable) {
       
        static NSString *identifire = @"ALeftCellID";
        ALeftCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ALeftCell" owner:nil options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            
        }
        AgentModel *model = self.agents[indexPath.row];
        cell.titleL.text = model.name;
        return cell;
        
        
        
    } else {
        
       
        static NSString *identifire = @"ARightCellID";
        ARightCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ARightCell" owner:nil options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        AgentDataModel *model = self.dataList[indexPath.section];
        cell.titleL.text = self.rightTitles[indexPath.row];
        

        if (indexPath.row == 0) {
            cell.numberL.text = model.serviceCount;
        }else if (indexPath.row == 1){
            cell.numberL.text = model.mercCount;
        }else if(indexPath.row == 1){
            cell.numberL.text = model.dayTradMoney;
        }else{
            cell.numberL.text = model.dayEarnMoney;
        }
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (tableView == self.rightTable) {
        
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        
        AgentDataModel *model = self.dataList[section];

        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:14];
        label.text = model.time;
        label.textColor = [UIColor colorWithHexString:@"#2F2F2F"];
        label.backgroundColor = [UIColor clearColor];
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).offset(20);
            make.top.bottom.equalTo(view);
        }];
     
        return view;
    }
    return [UIView new];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == self.rightTable) return 42;
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTable) return 42;
    return 42;
}


#pragma mark ~~~~~~~~~~ TableViewDelegate ~~~~~~~~~~
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTable) {
        
        [self.dataList removeAllObjects];
        [self.rightTable reloadData];
        self.agentModel = self.agents[indexPath.row];
        [self loadDataWithAgent:self.agents[indexPath.row]];
        
        
//        [self.rightTable reloadData];
//        [self.rightTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
//                               atScrollPosition:UITableViewScrollPositionNone animated:NO];

    }
    
    if (tableView == self.rightTable) {
        AgentDataModel *model = self.dataList[indexPath.section];
        switch (indexPath.row) {
            case 0:
            {
                ServiceVC *vc = [ServiceVC new];
                vc.model = model;
                vc.type = self.type;
                vc.agentModel = self.agentModel;
                [self.navigationController pushViewController:vc animated:YES];
                
            }
                break;
            case 1:
            {
                MerchantTotalVC *vc = [MerchantTotalVC new];
                vc.model = model;
                vc.type = self.type;
                vc.agentModel = self.agentModel;
                [self.navigationController pushViewController:vc animated:YES];
                
            }
                break;
            case 2:
            {
                DayTransactionVC *vc = [DayTransactionVC new];
                vc.model = model;
                vc.type = self.type;
                vc.agentModel = self.agentModel;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 3:
            {
                DayTotalProfitVC *vc = [DayTotalProfitVC new];
                vc.model = model;
                vc.type = self.type;
                vc.agentModel = self.agentModel;
                [self.navigationController pushViewController:vc animated:YES];
                
            }
                break;
                
            default:
                break;
        }
        

    }
    
   
    
}


//#pragma mark - 滚动刷新
//#pragma mark ~~~~~~~~~~ TableViewDataSource ~~~~~~~~~~
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    if (tableView == self.rightTable) {
//        return self.dataList.count;
//    }
//    return 1;
//}
//
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if (tableView == self.leftTable) {
//        return self.dataList.count;
//    }
//
//    return 4;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = nil;
//    if (tableView == self.leftTable) {
//        cell = [tableView dequeueReusableCellWithIdentifier:resueIdleft];
//        AchDetailModel *model = self.dataList[indexPath.row];
//        cell.textLabel.text = model.name;
//        return cell;
//    } else {
//        cell = [tableView dequeueReusableCellWithIdentifier:resueIdright];
//        // 获取选中leftTable那一行的数组
////        NSArray *arr = [self.array valueForKey:@"content"][indexPath.section];
//        AchDetailSubModel *model = self.dataList[]
//        cell.textLabel.text = @"3";
//        return cell;
//    }
//}
//
//#pragma mark ~~~~~~~~~~ TableViewDelegate ~~~~~~~~~~
//
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (tableView == self.leftTable) {
//        [self.rightTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row] atScrollPosition:UITableViewScrollPositionTop animated:YES];
//        self.isSelected = YES;
//    }
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//
//    if (tableView == self.rightTable) {
//
//        UIView *view = [[UIView alloc] init];
//        view.backgroundColor = [UIColor whiteColor];
//
//        UILabel *label = [[UILabel alloc] init];
//        label.font = [UIFont systemFontOfSize:14];
//        label.text = @"我的终端";
//        label.textColor = [UIColor colorWithHexString:@"#2F2F2F"];
//        label.backgroundColor = [UIColor clearColor];
//        [view addSubview:label];
//        [label mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(view).offset(20);
//            make.top.bottom.equalTo(view);
//        }];
//
//        return view;
//    }
//    return [UIView new];
//
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if (tableView == self.rightTable) return 44;
//
//    return 0;
//}
//
//// 头部视图将要显示时调用
//- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
//    if (tableView == self.rightTable) {
//        // 判断，如果是左边点击触发的滚动，这不执行下面代码
//        if (self.isSelected) {
//            return;
//        }
//        // 获取可见视图的第一个row
//        NSInteger currentSection = [[[self.rightTable indexPathsForVisibleRows] firstObject] section];
//        NSIndexPath *index = [NSIndexPath indexPathForRow:currentSection inSection:0];
//        // 点击左边对应区块
//        [self.leftTable selectRowAtIndexPath:index animated:YES scrollPosition:UITableViewScrollPositionTop];
//    }
//}
//
//// 开始拖动赋值没有点击
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    // 当右边视图将要开始拖动时，则认为没有被点击了。
//    self.isSelected = NO;
//}
//
#pragma mark - JXCategoryListContentViewDelegate
/**
 实现 <JXCategoryListContentViewDelegate> 协议方法，返回该视图控制器所拥有的「视图」
 */
- (UIView *)listView {
    return self.view;
}




@end
