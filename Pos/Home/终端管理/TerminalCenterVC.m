//
//  TerminalCenterVC.m
//  Pos
//
//  Created by 刘翔 on 2021/6/21.
//

#import "TerminalCenterVC.h"

@interface TerminalCenterVC ()

@property (nonatomic, copy) void(^scrollCallback)(UIScrollView *scrollView);
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *headerL;

@end

@implementation TerminalCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    self.customNavBar.hidden =YES;
    self.headerView.height = 40;
    self.tableView.tableHeaderView = self.headerView;
    self.headerL.text = [NSString stringWithFormat:@"%@总数：%@",self.headerTitle,self.model.count];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, kBottomSafeHeight, 0);
}



#pragma  mark --------UITableView Delegete----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(self.model)return self.model.children.count + 1;
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.model.myself.devices.count;
    }
    
    ChildrenModel *model = self.model.children[section - 1];

    return model.devices.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifire = @"cellID";
    LxSubTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LxSubTitleCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    BDeviceModel *model;
    if (indexPath.section == 0) {
        model = self.model.myself.devices[indexPath.row];
    }else{
        
        ChildrenModel *cmodel = self.model.children[indexPath.section - 1];
        model = cmodel.devices[indexPath.row];

    }
    cell.lab1.text = [NSString stringWithFormat:@"品牌设备编号%@",model.deviceNo];
    cell.lab2.text = model.modelName;
    
    
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.model) {
        return 54;

    }
    return 0;

    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.model == nil) {
        return [UIView new];

    }
    
   
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];

    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont boldSystemFontOfSize:14];
    label.textColor = [UIColor colorWithHexString:@"#282828"];
    label.backgroundColor = [UIColor clearColor];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(view).offset(20);
        make.top.equalTo(view).offset(20);
    }];
    
    if (section == 0) {
        label.text =[NSString stringWithFormat:@"本人设备总数：%ld台",self.model.myself.devices.count];
    }else{
        
        ChildrenModel *model = self.model.children[section - 1];
        label.text =[NSString stringWithFormat:@"直属代理%@设备总数：%ld台",model.proxyName,model.devices.count];

    }
    
    
    return view;
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
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
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
}

- (void)listDidDisappear {
    NSLog(@"%@:%@", self.title, NSStringFromSelector(_cmd));
}


@end
