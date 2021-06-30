//
//  LoginVC.m
//  Pos
//
//  Created by tenvine on 2021/6/16.
//

#import "LoginVC.h"

@interface LoginVC ()
@property (weak, nonatomic) IBOutlet UITextField *phoneF;
@property (weak, nonatomic) IBOutlet UITextField *passF;
@property (weak, nonatomic) IBOutlet UIButton *loginB;
@property (weak, nonatomic) IBOutlet UIButton *registB;
@property (weak, nonatomic) IBOutlet UIButton *forgetPB;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.hidden = YES;
    self.bottomView.hidden = YES;
    self.loginB.layer.cornerRadius = 22;
    self.loginB.layer.masksToBounds = YES;
    
    self.registB.layer.cornerRadius = 22;
    self.registB.layer.masksToBounds = YES;
    self.registB.layer.borderColor = [UIColor colorWithHexString:@"#707070"].CGColor;
    self.registB.layer.borderWidth = 1;
    
    
      
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"输入手机号" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#A2A2A2"],NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    self.phoneF.attributedPlaceholder = attrString;
    
    NSAttributedString *attrString1 = [[NSAttributedString alloc] initWithString:@"输入登陆密码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#A2A2A2"],NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    self.passF.attributedPlaceholder = attrString1;

  
    
}

- (IBAction)regitstAC:(id)sender {
    
    RegistVC *vc = [RegistVC new];
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)loginAC:(id)sender {
    
//    [HandleTool switchMainVC];
    
    if (_phoneF.text.length!=11) {
        [MBProgressHUD showError:@"请输入正确的手机号" toView:self.view];
        return;
    }
    
    if (_passF.text.length == 0) {
        [MBProgressHUD showError:@"请输入验证码！" toView:self.view];
        return;
    }
    
    //发送验证码接口
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_user_login];
    entity.parameters = @{@"password":self.passF.text,@"phone":self.phoneF.text};
    
    [MBProgressHUD showHUDAddedTo:lxMbProgressView animated:YES];
    
    [BANetManager ba_request_PUTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 200) {
            //倒计时
            LoginModel *model = [LoginModel mj_objectWithKeyValues:result[@"data"]];
            //设置网络请求头
            NSString *user_token = [NSString stringWithFormat:@"%@",model.token];
            NSDictionary *headerdic = @{@"token":user_token};
            [BANetManager sharedBANetManager].httpHeaderFieldDictionary = headerdic;

            //消息数据库打开，可以进入到主页面
            [LoginManger sharedManager].currentLoginModel = model;
            [HandleTool switchMainVC];
            [MBProgressHUD showMessag:@"登录成功" toView:lxMbProgressView];
            
           }
        } failureBlock:^(NSError *error) {
            
        } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
            
        }];
        
}


@end
