//
//  RegistVC.m
//  Pos
//
//  Created by 刘翔 on 2021/6/20.
//

#import "RegistVC.h"
#import "RegistReslutVC.h"

@interface RegistVC ()
@property (weak, nonatomic) IBOutlet UITextField *phoneF;
@property (weak, nonatomic) IBOutlet UITextField *yanF;
@property (weak, nonatomic) IBOutlet UITextField *passF;
@property (weak, nonatomic) IBOutlet UITextField *passAF;
@property (weak, nonatomic) IBOutlet UIButton *registB;
@property (weak, nonatomic) IBOutlet UIButton *yanB;
@property (weak, nonatomic) IBOutlet UITextField *invationF;

@end

@implementation RegistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.title = @"注册";
    [self setUI];
}

- (void)setUI{
    
    
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"请输入手机号" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#BCBCBC"],NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    self.phoneF.attributedPlaceholder = attrString;
    
    NSAttributedString *attrString1 = [[NSAttributedString alloc] initWithString:@"请输入验证码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#BCBCBC"],NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    self.yanF.attributedPlaceholder = attrString1;
    
    
    NSAttributedString *attrString3 = [[NSAttributedString alloc] initWithString:@"输入登陆密码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#BCBCBC"],NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    self.passF.attributedPlaceholder = attrString3;
    
    
    NSAttributedString *attrString4 = [[NSAttributedString alloc] initWithString:@"再次输入登录密码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#BCBCBC"],NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    self.passAF.attributedPlaceholder = attrString4;
    
    
    self.registB.layer.cornerRadius = 22;
    self.registB.layer.masksToBounds = YES;
    
}

- (IBAction)getSmsCode:(id)sender {
    
    if (_phoneF.text.length!=11) {
        [MBProgressHUD showError:@"请输入正确的手机号！" toView:self.view];
        return;
    }
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@%@",MainUrl,Url_register_sendSmsCode,self.phoneF.text];
    entity.needCache = NO;
    [MBProgressHUD showHUDAddedTo:lxMbProgressView animated:YES];
    [BANetManager ba_request_GETWithEntity:entity successBlock:^(id response) {
            NSDictionary *result = response;
            if ([result[@"code"] intValue] == 200) {
                //倒计时
                [self countDown];
            }
        } failureBlock:^(NSError *error) {
            
        } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
            
        }];
   
}

//倒计时
-(void)countDown
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
                [self.yanB setTitle:@"重新发送" forState:UIControlStateNormal];
                self.yanB.userInteractionEnabled = YES;
            });
        }else{
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮显示读秒效果
                [self.yanB setTitle:[NSString stringWithFormat:@"重新发送（%.2d）", seconds] forState:UIControlStateNormal];
                self.yanB.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}


- (IBAction)registAC:(id)sender {
    
    
    if (_phoneF.text.length!=11) {
        [MBProgressHUD showError:@"请输入正确的手机号！" toView:self.view];
        return;
    }
    
    if (_yanF.text.length == 0) {
        [MBProgressHUD showError:@"请输入验证码！" toView:self.view];
        return;
    }
    
    if (_passF.text.length == 0) {
        [MBProgressHUD showError:@"请输入密码！" toView:self.view];
        return;
    }
    
    if (_passAF.text.length == 0) {
        [MBProgressHUD showError:@"请再次输入密码！" toView:self.view];
        return;
    }
    
    if (_invationF.text.length == 0) {
        [MBProgressHUD showError:@"请输入邀请码！" toView:self.view];
        return;
    }
    
    if (![_passF.text isEqualToString:_passAF.text]) {
        [MBProgressHUD showError:@"两次密码输入不一样！" toView:self.view];
        return;
    }
    
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_user_register];
    entity.parameters = @{@"invitationCode":_invationF.text,@"password":self.passF.text,@"phone":self.phoneF.text,@"smsCode":self.yanF.text};
    
    [MBProgressHUD showHUDAddedTo:lxMbProgressView animated:YES];
    
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 200) {
            //倒计时
            RegistReslutVC *vc = [[RegistReslutVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
           }
        } failureBlock:^(NSError *error) {
            
        } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
            
        }];


    
}


@end
