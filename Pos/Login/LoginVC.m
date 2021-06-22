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
    
    [HandleTool switchMainVC];
}


@end
