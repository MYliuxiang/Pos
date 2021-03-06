//
//  ChangePasswordVC.m
//  Pos
//
//  Created by 李立 on 2021/6/24.
//

#import "ChangePasswordVC.h"

@interface ChangePasswordVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ChangePasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUI];
}
-(void)setUI{
    UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, [self ykStatusbarHeight]+12, kScreenWidth, 21)];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    titlelabel.font = [UIFont systemFontOfSize:16];
    titlelabel.text = @"修改密码";
    [self.view addSubview:titlelabel];
    
    //表视图
   self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, [self ykNavigationbarAndTopHeight]+20, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
   self.tableView.delegate = self;
   self.tableView.dataSource = self;
   self.tableView.bounces = NO;
   self.tableView.estimatedSectionFooterHeight = 0;
   self.tableView.estimatedSectionHeaderHeight = 0;
   self.tableView.backgroundColor = [UIColor clearColor];
   UIView *footview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    UIButton *querenbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    querenbutton.frame = CGRectMake((kScreenWidth-335)/2, 92, 335, 44);
    querenbutton.backgroundColor = [UIColor colorWithHexString:@"FF8901"];
    querenbutton.titleLabel.font = [UIFont systemFontOfSize:14];
    [querenbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    KViewBorderRadius(querenbutton, 22, 0.5, [UIColor clearColor]);
    [querenbutton addTarget:self action:@selector(querenbuttonaciton) forControlEvents:UIControlEventTouchUpInside];
    [querenbutton setTitle:@"确认" forState:UIControlStateNormal];
    [footview addSubview:querenbutton];
    
    footview.backgroundColor = [UIColor colorWithHexString:@"F6F6F6"];
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
   
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] init];
        [cell setRestorationIdentifier:@"MessageCell"];
    }
    NSArray *titlearry = @[@"旧密码",@"新密码",@"确认密码"];
    UIView *xtview = [[UIView alloc]initWithFrame:CGRectMake(0, 44-1, kScreenWidth, 1)];
    xtview.backgroundColor = [UIColor colorWithHexString:@"F6F6F6"];
    [cell.contentView addSubview:xtview];
    
    //输入框
    UITextField *textfield = [[UITextField alloc]initWithFrame:CGRectMake(109, 13, kScreenWidth-110, 19)];
    textfield.font = [UIFont systemFontOfSize:14];
    textfield.secureTextEntry = YES;
    [cell.contentView addSubview:textfield];
    
    if (indexPath.row ==0) {
        textfield.placeholder = @"请输入旧密码";
        self.oldtextifld = textfield;
    }else if (indexPath.row==1){
        textfield.placeholder = @"请输入新密码";
        self.newtextifld = textfield;
    }else{
        textfield.placeholder = @"请再次输入新密码";
        self.conttextifld = textfield;
    }
    
    cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
    cell.textLabel.text = titlearry[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark -UITableView代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

#pragma mark - 列表点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
      
    
}
//确认按钮提交
-(void)querenbuttonaciton{
       
    if (self.oldtextifld.text.length ==0) {
        [MBProgressHUD showError:@"请输入旧密码" toView:self.view];
        return;
    }
    
    if (self.newtextifld.text.length == 0) {
        [MBProgressHUD showError:@"请输入新密码" toView:self.view];
        return;
    }else{
        if (![self.newtextifld.text isEqualToString:self.conttextifld.text]) {
            [MBProgressHUD showError:@"两次密码不一致!" toView:self.view];
            return;
        }
    }
    
        BADataEntity *entity = [BADataEntity new];
        entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_resetPwd];
        entity.needCache = NO;
    entity.parameters =@{@"newPwd":self.newtextifld.text,@"oldPwd":self.oldtextifld.text};
        [BANetManager ba_request_PUTWithEntity:entity successBlock:^(id response) {
            NSDictionary *result = response;
            if ([result[@"code"] intValue] == 200) {
            [MBProgressHUD showSuccess:@"密码修改成功请重新登录" toView:self.view];
                dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));

                dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                    [LoginManger sharedManager].currentLoginModel = nil;
                    [HandleTool switchLgoinVC];
                });
           
            }
              
            } failureBlock:^(NSError *error) {
              

            } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
                
            }];
}
@end
