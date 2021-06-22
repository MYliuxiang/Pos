//
//  InformationVC.m
//  Pos
//
//  Created by 李立 on 2021/6/21.
//

#import "InformationVC.h"

@interface InformationVC ()<UITableViewDelegate,UITableViewDataSource,gzhPhotoManagerDelegate>

@end

@implementation InformationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人信息";
    [self setUI];
}

//初始化视图
-(void)setUI{
    UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, [self ykStatusbarHeight]+12, kScreenWidth, 21)];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    titlelabel.font = [UIFont systemFontOfSize:16];
    titlelabel.text = @"个人信息";
    [self.view addSubview:titlelabel];
    
    //表视图
   self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, [self ykNavigationbarAndTopHeight]+10, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
   self.tableView.delegate = self;
   self.tableView.dataSource = self;
   self.tableView.bounces = NO;
   self.tableView.estimatedSectionFooterHeight = 0;
//   self.tableView.estimatedSectionHeaderHeight = 0;
   self.tableView.backgroundColor = [UIColor clearColor];
   UIView *footview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.01)];
   self.tableView.tableFooterView = footview;
//    self.tableView.tableHeaderView = headview;
   [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
   [self.view addSubview:self.tableView];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 5;
    }else{
        return 2;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"JFletTableViewCell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] init];
        [cell setRestorationIdentifier:@"TransactionTableViewCell"];
    }
   
    //线条
    UIView *xtview = [[UIView alloc]initWithFrame:CGRectMake(53, 69-1, kScreenWidth, 1)];
    xtview.backgroundColor = [UIColor colorWithHexString:@"E9E9E9"];
    [cell addSubview:xtview];
    
    //箭头
    UIImageView *goinimagview = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-30, 29, 9.14, 16.26)];
    goinimagview.image = [UIImage imageNamed:@"返回(2)"];
    [cell addSubview:goinimagview];
    //显示值
    UILabel *afterlabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-200, 30, 150, 16)];
    afterlabel.textAlignment = NSTextAlignmentRight;
    afterlabel.font = [UIFont systemFontOfSize:14];
    afterlabel.textColor = [UIColor colorWithHexString:@"C4C4C4"];
    afterlabel.text = @"1111111";
    [cell addSubview:afterlabel];
    
    if (indexPath.section ==0) {
        NSArray *sectionarry = @[@"",@"姓名",@"手机号",@"直排人数",@"下排所有人数"];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.text = sectionarry[indexPath.row];
        if (indexPath.row ==0) {
        self.headimageview = [[UIImageView alloc]initWithFrame:CGRectMake(20, 11, 78, 78)];
        goinimagview.frame = CGRectMake(kScreenWidth-30, 43, 9.14, 16.26);
        KViewBorderRadius(self.headimageview, 39, 0.5, [UIColor clearColor]);
            self.headimageview.backgroundColor = [UIColor grayColor];
        [cell addSubview:self.headimageview];
        xtview.frame = CGRectMake(53, 101-1, kScreenWidth, 1);
        afterlabel.hidden = YES;
        }
        if (indexPath.row ==4) {
            xtview.hidden = YES;
        }
    }else if (indexPath.section ==1){
        goinimagview.hidden = YES;
        NSArray *sectionarry = @[@"推荐人",@"推荐人手机号"];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.text = sectionarry[indexPath.row];
        if (indexPath.row ==1) {
            xtview.hidden = YES;
        }
    }
    
    return cell;
}

#pragma mark -UITableView代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section ==0) {
        if (indexPath.row ==0) {
            return 101;
        }
    }
    return 69;
}
// 添加每组的组头
- (UIView *)tableView:(nonnull UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    if (section ==1) {
     view.frame =CGRectMake(0, 0, kScreenWidth, 50);
    UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 17, kScreenWidth-40, 21)];
    titlelabel.font = [UIFont systemFontOfSize:16];
    titlelabel.text = @"推荐人信息";
    [view addSubview:titlelabel];
     view.backgroundColor = [UIColor colorWithHexString:@"F6F6F6"];
    }
    return view;
 }
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section ==0) {
        return 0.01;
    }else{
        return 50;
    }
}
#pragma mark - 列表点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section ==0) {
        if (indexPath.row ==0) {
            //头像
            //调用
            [[gzhPhotoManager instance]selectPhotoWithController:self delegate:self size:CGSizeMake(kScreenWidth, kScreenWidth)];
        }
    }
  
}

-(void)selectedPhotoImage:(UIImage *)image{

    self.headimageview.image = image;
}
@end
