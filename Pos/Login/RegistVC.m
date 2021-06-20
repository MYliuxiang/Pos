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

- (IBAction)registAC:(id)sender {
    
    RegistReslutVC *vc = [[RegistReslutVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}


@end
