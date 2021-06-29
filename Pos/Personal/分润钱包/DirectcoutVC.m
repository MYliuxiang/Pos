//
//  DirectcoutVC.m
//  Pos
//
//  Created by 李立 on 2021/6/29.
//

#import "DirectcoutVC.h"
#import "DirectnessCell.h"

@interface DirectcoutVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation DirectcoutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUI];
}

//初始化视图
-(void)setUI{
    UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, [self ykStatusbarHeight]+12, kScreenWidth, 21)];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    titlelabel.font = [UIFont boldSystemFontOfSize:16];
    titlelabel.text = @"直属企业商户";
    [self.view addSubview:titlelabel];
    
    //表视图
   self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, [self ykNavigationbarAndTopHeight]+39, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
   self.tableView.delegate = self;
   self.tableView.dataSource = self;
   self.tableView.bounces = NO;
   self.tableView.estimatedSectionFooterHeight = 0;
//   self.tableView.estimatedSectionHeaderHeight = 0;
   self.tableView.backgroundColor = [UIColor clearColor];
//    self.tableView.tableHeaderView = headview;
   [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
   [self.view addSubview:self.tableView];
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section ==0) {
        return 1;
    }
    return 4;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //商户，交易额，贡献分润
    if (indexPath.section ==0) {
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        if (cell==nil) {
            cell=[[UITableViewCell alloc] init];
            [cell setRestorationIdentifier:@"UITableViewCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //线条
        UIView *xtview = [[UIView alloc]initWithFrame:CGRectMake(0, 80-1, kScreenWidth, 1)];
        xtview.backgroundColor = [UIColor colorWithHexString:@"E9E9E9"];
        [cell addSubview:xtview];
       
        xtview.frame = CGRectMake(0, 52-1, kScreenWidth, 1);
        //商户
        UILabel *shanghulabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 19, 60, 19)];
        shanghulabel.text = @"商户";
        shanghulabel.font = [UIFont boldSystemFontOfSize:14];
        [cell.contentView addSubview:shanghulabel];
        
        //交易额
        UILabel *jiaoyilabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 19, kScreenWidth, 19)];
        jiaoyilabel.text = @"交易额";
        jiaoyilabel.font = [UIFont boldSystemFontOfSize:14];
        jiaoyilabel.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:jiaoyilabel];
        
        //贡献分润
        UILabel *gongxianlabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-100, 19, 80, 19)];
        gongxianlabel.text = @"交易额";
        gongxianlabel.font = [UIFont boldSystemFontOfSize:14];
        gongxianlabel.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:gongxianlabel];
        return cell;
    }else{
    
    
    DirectnessCell *cell=[tableView dequeueReusableCellWithIdentifier:@"DirectnessCell"];
    if (cell==nil) {
        cell=[[DirectnessCell alloc] init];
        [cell setRestorationIdentifier:@"DirectnessCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //线条
    UIView *xtview = [[UIView alloc]initWithFrame:CGRectMake(0, 80-1, kScreenWidth, 1)];
    xtview.backgroundColor = [UIColor colorWithHexString:@"E9E9E9"];
    [cell addSubview:xtview];
   
  
    
    return cell;
    }
}

#pragma mark -UITableView代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section ==0) {
        return 52;
    }
    return 80;
}

#pragma mark - 列表点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
   
  
}
@end
