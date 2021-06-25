//
//  AchDetailSubVC.m
//  Pos
//
//  Created by tenvine on 2021/6/24.
//

#import "AchDetailSubVC.h"
#import "AchDetailModel.h"
#import "AchDetailSubModel.h"
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

@end

@implementation AchDetailSubVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.hidden = YES;
    self.bottomView.hidden = YES;
    self.rightTitles = @[@"服务商总数",@"商户总数",@"当月总交易额",@"当月总收益额"];
    
    self.dataList = [NSMutableArray array];
    
    for (int i = 0; i < 10; i++) {
        AchDetailModel *model = [[AchDetailModel alloc] init];
        model.name = [NSString stringWithFormat:@"张三%d",i];
        NSMutableArray *marray = [NSMutableArray array];
        
        for (int i = 0; i < 10; i++) {
            AchDetailSubModel *smodel = [[AchDetailSubModel alloc] init];
            smodel.time = [NSString stringWithFormat:@"2021-0%d",i];
            smodel.fwcount = @"300";
            smodel.shcount = @"300";
            smodel.totalProfit = @"300";
            smodel.totalTransaction = @"300";
            [marray addObject:smodel];
        }
        model.subModels = marray;
        [self.dataList addObject:model];
        
    }
    
    
    self.isSelected = NO;
    
    [self.leftTable selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];

//    // 初始化表格视图
//    [self initTableView];
    
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
    AchDetailModel *model = self.dataList[self.leftTable.indexPathForSelectedRow.row];
    return model.subModels.count;;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.leftTable) {
        return self.dataList.count;
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
        AchDetailModel *model = self.dataList[indexPath.row];
        cell.titleL.text = model.name;
        
        return cell;
        
        
        
    } else {
        
       
        static NSString *identifire = @"ARightCellID";
        ARightCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ARightCell" owner:nil options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        AchDetailModel *model = self.dataList[self.leftTable.indexPathForSelectedRow.row];
        AchDetailSubModel *smodel = model.subModels[indexPath.section];
        cell.titleL.text = self.rightTitles[indexPath.row];
       
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (tableView == self.rightTable) {
        
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        
        AchDetailModel *model = self.dataList[self.leftTable.indexPathForSelectedRow.row];
        AchDetailSubModel *smodel = model.subModels[section];

        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:14];
        label.text = smodel.time;
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
        [self.rightTable reloadData];
      
        [self.rightTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                               atScrollPosition:UITableViewScrollPositionNone animated:NO];

    }
    
    if (tableView == self.rightTable) {
        switch (indexPath.row) {
            case 0:
            {
                ServiceVC *vc = [ServiceVC new];
                [self.navigationController pushViewController:vc animated:YES];
                
            }
                break;
            case 1:
            {
                MerchantTotalVC *vc = [MerchantTotalVC new];
                [self.navigationController pushViewController:vc animated:YES];
                
            }
                break;
            case 2:
            {
                DayTransactionVC *vc = [DayTransactionVC new];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 3:
            {
                DayTotalProfitVC *vc = [DayTotalProfitVC new];
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
