//
//  PersonalVC.m
//  Pos
//
//  Created by tenvine on 2021/6/16.
//

#import "PersonalVC.h"
#import "InformationVC.h"
#import "AboutusVCViewController.h"
#import "ComplaintVC.h"
#import "MessagecenterVC.h"
#import "MoresettingsVC.h"
#import "PersonalcertificationVC.h"
#import "EnterpriseVC.h"
#import "FenrunWalletVC.h"
#import "MyorderVC.h"
#import "MybankcardVC.h"
#import "AdressVC.h"
#import "FaxianWalletVC.h"
#import "PersonaModel.h"
@interface PersonalVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)PersonaModel *model;

@end

@implementation PersonalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"个人中心";
    [self setUI];
    [self getdata];
}
//初始化视图
-(void)getdata{
    //轮播图
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_userAppInfo];
    entity.needCache = NO;

    [BANetManager ba_request_GETWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 200) {
           self.model = [PersonaModel mj_objectWithKeyValues:result[@"data"]];
            //加载头像
            [self.headimageview sd_setImageWithURL:[NSURL URLWithString:self.model.avatar]];
            NSDictionary *attrs = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:16]};
            CGSize size=[self.model.name sizeWithAttributes:attrs];
            [self.namelabel setFrame:CGRectMake(self.headimageview.right+11, self.headimageview.top+17, size.width, 21)];
            self.namelabel.text = self.model.name;
            self.yaoqview.frame = CGRectMake(self.namelabel.right+2,self.namelabel.top-2,138,24);
            self.iphonelabel.text = self.model.phone;
            self.yaoqingmalabel.text = [NSString stringWithFormat:@"我的邀请码：%@",self.model.invitationCode];
            [self.tableView reloadData];
        }
          
      

        } failureBlock:^(NSError *error) {
          

        } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
            
        }];
}

//初始化视图
-(void)setUI{
    
    UIView *headview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 231+[self ykStatusbarHeight])];
    headview.backgroundColor = [UIColor whiteColor];
    
    //个人中心点击视图
    UIView *tapview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 153+[self ykStatusbarHeight])];
    tapview.backgroundColor = [UIColor colorWithHexString:@"FF8901"];
    tapview.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapgest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapviewaction)];
    [tapview addGestureRecognizer:tapgest];
    [headview addSubview:tapview];
    
    //头像
    self.headimageview = [[UIImageView alloc]initWithFrame:CGRectMake(40, 36+[self ykStatusbarHeight], 78, 78)];
    self.headimageview.backgroundColor = [UIColor grayColor];
    KViewBorderRadius(self.headimageview, 39, 0.5, [UIColor clearColor]);
    [tapview addSubview:self.headimageview];
    
    //昵称
    self.namelabel = [[UILabel alloc]initWithFrame:CGRectMake(self.headimageview.right+21, self.headimageview.top+17, 65, 21)];
    self.namelabel.font = [UIFont systemFontOfSize:16];
    self.namelabel.text = @"张三跑";
    self.namelabel.textColor = [UIColor whiteColor];
    [tapview addSubview:self.namelabel];
    
    //手机号码
    self.iphonelabel = [[UILabel alloc]initWithFrame:CGRectMake(self.namelabel.left, self.namelabel.bottom+9, 120, 17)];
    self.iphonelabel.font = [UIFont systemFontOfSize:16];
    self.iphonelabel.textColor = [UIColor colorWithHexString:@"FFC98B"];
    self.iphonelabel.text = @"13299998888";
    [tapview addSubview:self.iphonelabel];
    
    self.yaoqview = [[UIView alloc] init];
    self.yaoqview.frame = CGRectMake(self.namelabel.right+2,self.namelabel.top-2,138,24);
    self.yaoqview.alpha = 1.0;
    self.yaoqview.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    self.yaoqview.layer.cornerRadius = 12;
    [tapview addSubview:self.yaoqview];
    //我的邀请码
    self.yaoqingmalabel = [[UILabel alloc]initWithFrame:CGRectMake(11, 4, 148-22, 16)];
    self.yaoqingmalabel.font = [UIFont systemFontOfSize:12];
    self.yaoqingmalabel.textColor = [UIColor colorWithHexString:@"FF8901"];
    self.yaoqingmalabel.text = @"我的邀请码：889N0U";
    [self.yaoqview  addSubview:self.yaoqingmalabel];
    
    //进入图标
    UIImageView *goinimageview = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-30, 67+[self ykStatusbarHeight], 9.14, 16.26)];
    goinimageview.image = [UIImage imageNamed:@"返回(1)"];
    [tapview addSubview:goinimageview];
    
    //分润，返现，卡包
    NSArray *titlearry = @[@"分润",@"返现",@"卡包"];
    
    for (int i = 0; i<titlearry.count; i++) {
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(i*((kScreenWidth-70)/3)+70, tapview.bottom+17, 23.29, 19.36)];
        imageview.image = [UIImage imageNamed:titlearry[i]];
        [headview addSubview:imageview];
        
        //文字
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(imageview.left, imageview.bottom+10, imageview.width+10, 19)];
        label.font = [UIFont systemFontOfSize:14];
        label.text = titlearry[i];
        label.textColor = [UIColor colorWithHexString:@"232323"];
        [headview addSubview:label];
        
        UIButton *buttuon = [UIButton buttonWithType:UIButtonTypeCustom];
        buttuon.frame = CGRectMake(imageview.left, imageview.top-5, label.width+10, 55);
        buttuon.tag = 50+i;
        buttuon.backgroundColor = [UIColor clearColor];
        [buttuon addTarget:self action:@selector(buttonction:) forControlEvents:UIControlEventTouchUpInside];
        [headview addSubview:buttuon];
        
        if (i==0) {
            //分割线
            UIView *fegeview = [[UIView alloc]initWithFrame:CGRectMake(0, label.bottom+12, kScreenWidth, 10)];
            fegeview.backgroundColor = [UIColor colorWithHexString:@"F6F6F6"];
            [headview addSubview:fegeview];
        }
    }
    
   
    
    
    
    //表视图
   self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - Height_TabBar) style:UITableViewStylePlain];
   self.tableView.delegate = self;
   self.tableView.dataSource = self;
   self.tableView.bounces = YES;
   self.tableView.estimatedSectionFooterHeight = 0;
   self.tableView.estimatedSectionHeaderHeight = 10;
   self.tableView.backgroundColor = [UIColor clearColor];
   UIView *footview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.01)];
   self.tableView.tableFooterView = footview;
    self.tableView.tableHeaderView = headview;
   [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
   [self.view addSubview:self.tableView];
    
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 2;
    }else if (section ==1){
        return 2;
    }else{
        return 5;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"JFletTableViewCell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] init];
        [cell setRestorationIdentifier:@"TransactionTableViewCell"];
    }
   
    //线条
    UIView *xtview = [[UIView alloc]initWithFrame:CGRectMake(53, 54-1, kScreenWidth, 1)];
    xtview.backgroundColor = [UIColor colorWithHexString:@"E9E9E9"];
    [cell addSubview:xtview];
    
    //箭头
    UIImageView *goinimagview = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-30, 17, 9.14, 16.26)];
    goinimagview.image = [UIImage imageNamed:@"返回(2)"];
    [cell addSubview:goinimagview];
    
    if (indexPath.section ==0) {
        NSArray *sectionarry = @[@"订单查询",@"地址管理"];
        cell.imageView.image = [UIImage imageNamed:sectionarry[indexPath.row]];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.text = sectionarry[indexPath.row];
        if (indexPath.row ==1) {
            xtview.hidden = YES;
        }
    }else if (indexPath.section ==1){
        NSArray *sectionarry = @[@"实名认证",@"企业认证"];
        cell.imageView.image = [UIImage imageNamed:sectionarry[indexPath.row]];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.text = sectionarry[indexPath.row];
        if (indexPath.row ==1) {
            xtview.hidden = YES;
        }
    }else{
        NSArray *sectionarry = @[@"消息中心",@"联系客服",@"投诉建议",@"关于我们",@"更多设置"];
        cell.imageView.image = [UIImage imageNamed:sectionarry[indexPath.row]];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.text = sectionarry[indexPath.row];
        if (indexPath.row ==4) {
            xtview.hidden = YES;
        }
    }
    
    return cell;
}

#pragma mark -UITableView代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 54;
}

#pragma mark - 列表点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section ==0) {
        if (indexPath.row==0) {
        //订单查询
        MyorderVC *vc = [[MyorderVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        }else{
           //地址管理
            AdressVC *vc = [[AdressVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
    }else if (indexPath.section==1) {
        if (indexPath.row==0) {
            //实名认证
        PersonalcertificationVC *vc = [[PersonalcertificationVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        }else{
            //企业认证
            EnterpriseVC *VC = [[EnterpriseVC alloc]init];
            [self.navigationController pushViewController:VC animated:YES];
        }
    }else {
        if (indexPath.row ==0) {
            //消息中心
            MessagecenterVC *vc = [[MessagecenterVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row==1){
            //联系客服
        }else if (indexPath.row==2){
            //投诉建议
            ComplaintVC *vc = [[ComplaintVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row==3){
        //关于我们
        AboutusVCViewController *vc = [[AboutusVCViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
            
        }else{
            //更多设置
            MoresettingsVC *VC = [[MoresettingsVC alloc]init];
            [self.navigationController pushViewController:VC animated:YES];
        }
        
    }
}

// 添加每组的组头
- (UIView *)tableView:(nonnull UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
 
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    view.backgroundColor = [UIColor colorWithHexString:@"F6F6F6"];
    return view;
 }

//点击按钮
-(void)buttonction:(UIButton *)button{
    
    if (button.tag ==50) {
         //分润
        FenrunWalletVC *VC = [[FenrunWalletVC alloc]init];
        [self.navigationController pushViewController:VC animated:YES];
    }else if (button.tag ==51){
        //返现钱包
        FaxianWalletVC *VC = [[FaxianWalletVC alloc]init];
        [self.navigationController pushViewController:VC animated:YES];
    }else{
        //卡包
        MybankcardVC *vc = [[MybankcardVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

//个人信息页面
-(void)tapviewaction{
    InformationVC *VC = [[InformationVC alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
}
@end
