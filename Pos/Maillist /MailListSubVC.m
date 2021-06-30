//
//  MailListSubVC.m
//  Pos
//
//  Created by 刘翔 on 2021/6/27.
//

#import "MailListSubVC.h"
#import "MailListCell.h"

@interface MailListSubVC ()
@property (nonatomic, copy) void(^scrollCallback)(UIScrollView *scrollView);
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITableView *tableView1;
@property (weak, nonatomic) IBOutlet UIButton *sortB;
@property (weak, nonatomic) IBOutlet UILabel *totalL;

@property (strong, nonatomic) UIView *maskView;
@property (copy, nonatomic) NSArray *sortTitles;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sortConstraint;
@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, assign) NSInteger sortType;


@end

@implementation MailListSubVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.hidden = YES;
    self.dataList = [NSMutableArray array];
    [self setUI];
    self.sortType = 1;
    self.sortTitles = @[@"默认排序",@"用户收益从高到低",@"用户规模从高到低",@"交易额从高到低"];
    self.tableView.mj_header = [LxResfreshHeader headerWithRefreshingBlock:^{
        self.pageNum = 1;
        [self loadData];
    }];
    [self.tableView.mj_header beginRefreshing];

}

- (void)setKeyword:(NSString *)keyword
{
    _keyword = keyword;
    [self loadData];
}

- (void)loadData{
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@%ld",MainUrl,Url_user_contacts,(long)self.sortType];
    NSString *verified;
    if (self.type == 0) {
        //已经实名的
        verified = @"1";
    }else{
        verified = @"0";

    }
    entity.needCache = NO;
    if(self.keyword == nil){
        entity.parameters = @{@"verified":verified,@"pageNum":@(self.pageNum),@"pageSize":@(PageSize)};
    }else{
        entity.parameters = @{@"verified":verified,@"pageNum":@(self.pageNum),@"pageSize":@(PageSize),@"search":[NSString stringWithFormat:@"%@",self.keyword]};
    }
   
    [BANetManager ba_request_GETWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 200) {
            
            NSArray *models = [ContactsModel mj_objectArrayWithKeyValuesArray:result[@"data"]];
            if (self.pageNum == 1) {
                [self.dataList removeAllObjects];
            }
            [self.dataList addObjectsFromArray:models];
            
            self.totalL.text = [NSString stringWithFormat:@"通讯录：%ld",self.dataList.count];
            
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




- (void)setUI{
    
    [self.sortB layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
    self.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 130 + Height_NavBar + 44 + 143, kScreenWidth, kScreenHeight - 130 - Height_NavBar - 44)];
    self.maskView.backgroundColor = [UIColor colorWithRed:6/255.0 green:6/255.0 blue:6/255.0 alpha:0.46];
    self.maskView.hidden = YES;
        
    [lxWindow addSubview:self.maskView];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sortCancleAC)];
    [self.maskView addGestureRecognizer:tap];
    
}

- (void)sortCancleAC{
    
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:0.35 animations:^{
        self.maskView.hidden = YES;
        self.sortConstraint.constant = 0;

    }];
    self.sortB.selected = NO;
}

- (IBAction)sortAC:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.selected;
    if (btn.selected) {
        [self.view layoutIfNeeded];
        [UIView animateWithDuration:0.35 animations:^{
            self.maskView.hidden = NO;
            self.sortConstraint.constant = 143;

        }];

    }else{
        
        [self.view layoutIfNeeded];
        [UIView animateWithDuration:0.35 animations:^{
            self.maskView.hidden = YES;
            self.sortConstraint.constant = 0;

        }];
    }
    
   
    
    
    
}


#pragma  mark --------UITableView Delegete----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView1) {
        return self.sortTitles.count;
    }
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.tableView1) {
        static NSString *identifire = @"celloneID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifire];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        cell.textLabel.text = self.sortTitles[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#C4C4C4"];
        return cell;
    }
    static NSString *identifire = @"cellID";
    MailListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MailListCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    cell.model = self.dataList[indexPath.row];
    
    return cell;
    
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
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView1) {
        return 47;
    }
    return 93;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView1) {
        [self.sortB setTitle:self.sortTitles[indexPath.row] forState:UIControlStateNormal];
        [self.sortB layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
        [self sortCancleAC];
        
        self.sortType = indexPath.row;
        [self.tableView.mj_header beginRefreshing];
                
    }else{
        
        ContactsModel *model = self.dataList[indexPath.row];
        NSString *phoneStr = [NSString stringWithFormat:@"tel://%@",model.phone];
        //设备系统为IOS 10.0或者以上的
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneStr] options:@{} completionHandler:nil];
        } else {
            // Fallback on earlier versions
            //设备系统为IOS 10.0以下的
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneStr]];
        }
        
       
     
    }
}




- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    !self.scrollCallback ?: self.scrollCallback(scrollView);
}

#pragma mark - JXPagingViewListViewDelegate

- (UIView *)listView {
    return self.view;
}

- (UIScrollView *)listScrollView {
    return self.tableView;
}

- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    self.scrollCallback = callback;
}

- (void)listWillAppear {
    NSLog(@"%@:%@", self.title, NSStringFromSelector(_cmd));
}

- (void)listDidAppear {
    NSLog(@"%@:%@", self.title, NSStringFromSelector(_cmd));
}

- (void)listWillDisappear {
    NSLog(@"%@:%@", self.title, NSStringFromSelector(_cmd));
    [self sortCancleAC];

}

- (void)listDidDisappear {
    NSLog(@"%@:%@", self.title, NSStringFromSelector(_cmd));
}



@end
