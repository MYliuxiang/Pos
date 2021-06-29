//
//  RecruitmentVC.m
//  Pos
//
//  Created by 李立 on 2021/6/29.
//

#import "RecruitmentVC.h"
#import "RecruitmeCell.h"
@interface RecruitmentVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation RecruitmentVC

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
    titlelabel.text = @"招募奖";
    [self.view addSubview:titlelabel];
    
    //头视图
    UIView *headview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 173)];
    headview.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];
    
    //白色视图
    UIView *baiseview = [[UIView alloc]initWithFrame:CGRectMake(14, 20, kScreenWidth-28, 133)];
    baiseview.backgroundColor = [UIColor whiteColor];
    [headview addSubview:baiseview];
    
    //价格
    self.moneylabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 41, baiseview.width, 31)];
    self.moneylabel.font = [UIFont boldSystemFontOfSize:28];
    self.moneylabel.textColor = [UIColor colorWithHexString:@"#FF8901"];
    self.moneylabel.text = @"9098.00";
    self.moneylabel.textAlignment = NSTextAlignmentCenter;
    [baiseview addSubview:self.moneylabel];
    
    //累积奖励
    UILabel *secondlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.moneylabel.bottom+13, baiseview.width, 19)];
    secondlabel.font = [UIFont systemFontOfSize:14];
    secondlabel.text = @"累积奖励金额（元）";
    secondlabel.textColor = [UIColor colorWithHexString:@"#BDBDBD"];
    secondlabel.textAlignment = NSTextAlignmentCenter;
    [baiseview addSubview:secondlabel];
    
    //表视图
   self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, [self ykNavigationbarAndTopHeight], kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
   self.tableView.delegate = self;
   self.tableView.dataSource = self;
   self.tableView.bounces = NO;
   self.tableView.estimatedSectionFooterHeight = 0;
//   self.tableView.estimatedSectionHeaderHeight = 0;
   self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = headview;
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
        shanghulabel.text = @"服务商";
        shanghulabel.font = [UIFont boldSystemFontOfSize:14];
        [cell.contentView addSubview:shanghulabel];
        
        //交易额
        UILabel *jiaoyilabel = [[UILabel alloc]initWithFrame:CGRectMake(shanghulabel.right+55, 19, 60, 19)];
        jiaoyilabel.text = @"激活台数";
        jiaoyilabel.font = [UIFont boldSystemFontOfSize:14];
        jiaoyilabel.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:jiaoyilabel];
        
        UILabel *dabiaolabel = [[UILabel alloc]initWithFrame:CGRectMake(jiaoyilabel.right+45, 19, 60, 19)];
        dabiaolabel.text = @"是否达标";
        dabiaolabel.font = [UIFont boldSystemFontOfSize:14];
        dabiaolabel.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:dabiaolabel];
        
        //贡献分润
        UILabel *gongxianlabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-100, 19, 80, 19)];
        gongxianlabel.text = @"奖励金额";
        gongxianlabel.font = [UIFont boldSystemFontOfSize:14];
        gongxianlabel.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:gongxianlabel];
        return cell;
    }else{
        
        RecruitmeCell *cell=[tableView dequeueReusableCellWithIdentifier:@"RecruitmeCell"];
    if (cell==nil) {
        cell=[[RecruitmeCell alloc] init];
        [cell setRestorationIdentifier:@"RecruitmeCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //线条
    UIView *xtview = [[UIView alloc]initWithFrame:CGRectMake(0, 45-1, kScreenWidth, 1)];
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
    return 58;
}

#pragma mark - 列表点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
   
  
}
@end
