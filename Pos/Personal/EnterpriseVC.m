//
//  EnterpriseVC.m
//  Pos
//
//  Created by 李立 on 2021/6/26.
//

#import "EnterpriseVC.h"

@interface EnterpriseVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation EnterpriseVC

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
    titlelabel.text = @"企业认证";
    [self.view addSubview:titlelabel];
    
    //表视图
   self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, [self ykNavigationbarAndTopHeight]+10, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
   self.tableView.delegate = self;
   self.tableView.dataSource = self;
   self.tableView.bounces = NO;
   self.tableView.estimatedSectionFooterHeight = 0;
//   self.tableView.estimatedSectionHeaderHeight = 0;
   self.tableView.backgroundColor = [UIColor clearColor];
   UIView *footview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 400)];
    footview.backgroundColor = [UIColor colorWithHexString:@"F6F6F6"];
    UIButton *tijiaobutton = [UIButton buttonWithType:UIButtonTypeCustom];
    tijiaobutton.frame = CGRectMake((kScreenWidth-336)/2, 168, 336, 44);
    KViewBorderRadius(tijiaobutton, 22, 0.5, [UIColor clearColor]);
    tijiaobutton.backgroundColor = [UIColor colorWithHexString:@"FF8901"];
    tijiaobutton.titleLabel.font = [UIFont systemFontOfSize:14];
    [tijiaobutton setTitle:@"提交" forState:UIControlStateNormal];
    [tijiaobutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [tijiaobutton addTarget:self action:@selector(tijiaoaction) forControlEvents:UIControlEventTouchUpInside];
    [footview addSubview:tijiaobutton];
   self.tableView.tableFooterView = footview;
//    self.tableView.tableHeaderView = headview;
   [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
   [self.view addSubview:self.tableView];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"JFletTableViewCell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] init];
        [cell setRestorationIdentifier:@"TransactionTableViewCell"];
    }
   
    //线条
    UIView *xtview = [[UIView alloc]initWithFrame:CGRectMake(22, 69-1, kScreenWidth, 1)];
    xtview.backgroundColor = [UIColor colorWithHexString:@"E9E9E9"];
    [cell addSubview:xtview];
    
  
    //显示值
    UITextField *afterlabel = [[UITextField alloc]initWithFrame:CGRectMake(kScreenWidth-200, 30, 180, 16)];
    afterlabel.textAlignment = NSTextAlignmentRight;
    afterlabel.font = [UIFont systemFontOfSize:14];
    afterlabel.textColor = [UIColor colorWithHexString:@"C4C4C4"];
    [cell addSubview:afterlabel];
    
    if (indexPath.section ==0) {
        NSArray *sectionarry = @[@"企业名称",@"法  人",@"企业地址",@""];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.text = sectionarry[indexPath.row];
      
        xtview.frame = CGRectMake(22, 60-1, kScreenWidth, 1);
        afterlabel.text = @"王小二";
        if (indexPath.row ==3) {
            xtview.hidden = YES;
            afterlabel.text = @"";
        //营业执照
        UILabel *zhizhaolable = [[UILabel alloc]initWithFrame:CGRectMake(21, 20, 100, 19)];
        zhizhaolable.font = [UIFont systemFontOfSize:14];
        zhizhaolable.text = @"营业执照";
       [cell.contentView addSubview:zhizhaolable];
         //营业执照
        self.zimageview = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-239)/2, zhizhaolable.bottom+57, 239, 140)];
        self.zimageview.backgroundColor = [UIColor grayColor];
        [cell.contentView addSubview:self.zimageview];
          
        //文字
        UILabel *zlabel = [[UILabel alloc]initWithFrame:CGRectMake(self.zimageview.left, self.zimageview.bottom+11, self.zimageview.width, 19)];
        zlabel.textColor = [UIColor colorWithHexString:@"FF8901"];
        zlabel.text = @"营业执照";
        zlabel.font = [UIFont systemFontOfSize:14];
        zlabel.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:zlabel];
        }
    }
    return cell;
}


#pragma mark -UITableView代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row ==3) {
        return 287;
    }
    return 60;
}

#pragma mark - 列表点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
   
  
}

//正面照
-(void)tap1aciton{
    
}

//反面照
-(void)tap1aciton2{
    
}
//提交按钮
-(void)tijiaoaction{
    
}
@end
