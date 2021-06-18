//
//  DataShowVC.m
//  Pos
//
//  Created by tenvine on 2021/6/18.
//

#import "DataShowVC.h"
#import "DataShowCell.h"
#import "DataModel.h"

@interface DataShowVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataList;
@property (nonatomic, strong)NSMutableArray *lastShowList;
@property (nonatomic, strong) NSMutableArray *oldShowList;





@end

@implementation DataShowVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.title = @"数据展示";
    self.dataList = [NSMutableArray array];
    self.lastShowList = [NSMutableArray array];
    self.oldShowList = [NSMutableArray array];

    [self.tableView registerClass:[DataShowCell class] forCellReuseIdentifier:@"cellID"];
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;


    
    for (int i = 0; i < 3; i++) {
        
        NSMutableArray *smarray = [NSMutableArray array];
        for (int i = 0; i < 3; i++) {
            DataModel *model = [[DataModel alloc] init];
            model.title = @"新增XX品牌";
            model.isUnfold = NO;
            [smarray addObject:model];
        }
        
        NSMutableArray *marray = [NSMutableArray array];
        DataModel *model = [[DataModel alloc] init];
        for (int i = 0; i < 3; i++) {
            model.title = @"XX代理今日新增商户（45户）";
            model.isUnfold = NO;
            model.subs = smarray;
            [marray addObject:model];
        }
        
        [self.dataList addObject:marray];
    }
    
    [self setupRowCount];

}

#pragma mark - < 添加可以展示的选项 >

- (void)setupRowCount
{
    // 清空当前所有展示项
    [self.lastShowList removeAllObjects];
    
    // 重新添加需要展示项, 并设置层级, 初始化0
    [self setupRouCountWithDatas:self.dataList];
}

/**
 将需要展示的选项添加到latestShowMenuItems中, 此方法使用递归添加所有需要展示的层级到latestShowMenuItems中
 @param menuItems 需要添加到latestShowMenuItems中的数据
 @param index 层级, 即当前添加的数据属于第几层
 */
- (void)setupRouCountWithDatas:(NSArray *)datas
{
    for (int i = 0; i < datas.count; i++) {
        
        NSArray *array = datas[i];
        NSMutableArray *marray = [NSMutableArray array];
        for (int i = 0; i < array.count; i++) {
            
            DataModel *model = array[i];
            // 将选项添加到数组中
            [marray addObject:model];
        }
        [self.lastShowList addObject:marray];
    }
    
    
}


#pragma  mark --------UITableView Delegete----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.lastShowList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSArray *array = self.lastShowList[section];
    return  array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifire = @"cellID";
    
    DataShowCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire forIndexPath:indexPath];
//    DataModel *model = self.lastShowList[indexPath.section];
//    cell.model = model.subs[indexPath.row];
    cell.model = self.lastShowList[indexPath.section][indexPath.row];

    return cell;
    
        
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 52;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont boldSystemFontOfSize:16];
    label.text = @"今日新增商户数：4户";
    label.textColor = [UIColor colorWithHexString:@"#FF7D01"];
    label.backgroundColor = [UIColor clearColor];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(view).offset(21);
        make.top.equalTo(view).offset(23);
    }];
    
    return view;
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
    DataModel *menuItem = self.lastShowList[indexPath.section][indexPath.row];
    if (!menuItem.isCanUnfold) return;
    
    self.oldShowList = [NSMutableArray arrayWithArray:self.lastShowList];
    
    // 设置展开闭合
    menuItem.isUnfold = !menuItem.isUnfold;
    // 更新被点击cell的箭头指向
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationAutomatic)];
    
    // 设置需要展开的新数据
    [self setupRowCount];
    
    // 判断老数据和新数据的数量, 来进行展开和闭合动画
    // 定义一个数组, 用于存放需要展开闭合的indexPath
    NSMutableArray<NSIndexPath *> *indexPaths = @[].mutableCopy;
    
    // 如果 老数据 比 新数据 多, 那么就需要进行闭合操作
    if (self.oldShowList.count > self.lastShowList.count) {
        // 遍历oldShowMenuItems, 找出多余的老数据对应的indexPath
        for (int i = 0; i < self.oldShowList.count; i++) {
            // 当新数据中 没有对应的item时
            if (![self.lastShowList containsObject:self.oldShowList[i]]) {
                NSIndexPath *subIndexPath = [NSIndexPath indexPathForRow:i inSection:indexPath.section];
                [indexPaths addObject:subIndexPath];
            }
        }
        // 移除找到的多余indexPath
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:(UITableViewRowAnimationTop)];
    }else {
        // 此时 新数据 比 老数据 多, 进行展开操作
        // 遍历 latestShowMenuItems, 找出 oldShowMenuItems 中没有的选项, 就是需要新增的indexPath
        for (int i = 0; i < self.lastShowList.count; i++) {
            if (![self.oldShowList containsObject:self.lastShowList[i]]) {
                NSIndexPath *subIndexPath = [NSIndexPath indexPathForRow:i inSection:indexPath.section];
                [indexPaths addObject:subIndexPath];
            }
        }
        // 插入找到新添加的indexPath
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:(UITableViewRowAnimationTop)];
    }
    
    
}





@end
