//
//  ChangiphoneVC.m
//  Pos
//
//  Created by 李立 on 2021/6/24.
//

#import "ChangiphoneVC.h"

@interface ChangiphoneVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ChangiphoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUI];
}

-(void)setUI{
    UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, [self ykStatusbarHeight]+12, kScreenWidth, 21)];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    titlelabel.font = [UIFont systemFontOfSize:16];
    titlelabel.text = @"修改手机号";
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
    [querenbutton setTitle:@"确定" forState:UIControlStateNormal];
    [querenbutton addTarget:self action:@selector(querenbuttonacion) forControlEvents:UIControlEventTouchUpInside];
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
   
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] init];
        [cell setRestorationIdentifier:@"MessageCell"];
    }
    NSArray *titlearry = @[@"注册身份证",@"结算银行卡",@"新 手 机 号",@"验   证   码"];
    UIView *xtview = [[UIView alloc]initWithFrame:CGRectMake(0, 44-1, kScreenWidth, 1)];
    xtview.backgroundColor = [UIColor colorWithHexString:@"F6F6F6"];
    [cell.contentView addSubview:xtview];
    
    //输入框
    UITextField *textfield = [[UITextField alloc]initWithFrame:CGRectMake(109, 13, kScreenWidth-110, 19)];
    textfield.font = [UIFont systemFontOfSize:14];
//    textfield.secureTextEntry = YES;
    textfield.keyboardType = UIKeyboardTypeNumberPad;
    [cell.contentView addSubview:textfield];
    
    if (indexPath.row ==0) {
        textfield.placeholder = @"请输入身份证号";
        self.caridtifld = textfield;
    }else if (indexPath.row==1){
        textfield.placeholder = @"请输入当前结算银行卡号";
        self.yinhangtifld = textfield;
    }else if (indexPath.row==2){
        textfield.placeholder = @"新手机号";
        self.iphonetextifld = textfield;
    }else{
        //分割线
        UIView *fengeview = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth-101, 10, 1, 25)];
        fengeview.backgroundColor = [UIColor colorWithHexString:@"BCBCBC"];
        [cell.contentView addSubview:fengeview];
        //获取验证码按钮
        self.huoqubutton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.huoqubutton.frame = CGRectMake(fengeview.right+10, 12, 80, 19);
        [self.huoqubutton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.huoqubutton setTitleColor:[UIColor colorWithHexString:@"FF8901"] forState:UIControlStateNormal];
        self.huoqubutton.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.huoqubutton addTarget:self action:@selector(codeaction) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:self.huoqubutton];
        textfield.placeholder = @"请输入验证码";
        self.yzmtextifld = textfield;
    }
    
    cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
    cell.textLabel.text = titlearry[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
//获取验证码
-(void)codeaction{
    if (self.iphonetextifld.text.length !=11) {
        [MBProgressHUD showError:@"请输入正确的手机号" toView:self.view];
        return;
    }
    
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@%@",MainUrl,Url_changesmsnew,self.iphonetextifld.text];
    entity.needCache = NO;
    [BANetManager ba_request_GETWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 200) {
        [MBProgressHUD showSuccess:@"验证码发送成功" toView:self.view];
            [self huoqu];
        }else{
            [MBProgressHUD showError:result[@"msg"] toView:self.view];

        }
          
        } failureBlock:^(NSError *error) {
          

        } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
            
        }];
    
    
    
   
  
}

//倒计时
-(void)huoqu
{
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [self->_huoqubutton setTitle:@"重新发送" forState:UIControlStateNormal];
                self->_huoqubutton.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [self->_huoqubutton setTitle:[NSString stringWithFormat:@"%.2ds", seconds] forState:UIControlStateNormal];
                self->_huoqubutton.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}



#pragma mark -UITableView代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

#pragma mark - 列表点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
      
    
}

//确认修改手机号
-(void)querenbuttonacion{
    if (self.caridtifld.text.length ==0) {
        [MBProgressHUD showError:@"请输入身份证" toView:self.view];
        return;
    }
    if (self.yinhangtifld.text.length ==0) {
        [MBProgressHUD showError:@"请输入结算银行卡" toView:self.view];
        return;
    }
    if (self.iphonetextifld.text.length ==0) {
        [MBProgressHUD showError:@"请输入新手机号" toView:self.view];
        return;
    }
    if (self.yzmtextifld.text.length ==0) {
        [MBProgressHUD showError:@"请输入验证码" toView:self.view];
        return;
    }
    
            BADataEntity *entity = [BADataEntity new];
            entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_changeiphone2];
            entity.needCache = NO;
    entity.parameters =@{@"bankNo":self.yinhangtifld.text,@"idCard":self.caridtifld.text,@"newPhone":self.iphonetextifld.text,@"smsCode":self.yzmtextifld.text};
            [BANetManager ba_request_PUTWithEntity:entity successBlock:^(id response) {
                NSDictionary *result = response;
                if ([result[@"code"] intValue] == 200) {
                [MBProgressHUD showSuccess:@"手机号修改成功请重新登录" toView:self.view];
                    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));

                    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
//                        [LoginManger sharedManager].currentLoginModel = nil;
//                        [HandleTool switchLgoinVC];
                    });
               
                }
                  
                } failureBlock:^(NSError *error) {
                  

                } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
                    
                }];
}
@end
