//
//  ToFaceVC.m
//  Pos
//
//  Created by tenvine on 2021/6/22.
//

#import "ToFaceVC.h"

@interface ToFaceVC ()
@property (weak, nonatomic) IBOutlet UITextField *phoneF;
@property (weak, nonatomic) IBOutlet UITextField *yanF;
@property (weak, nonatomic) IBOutlet UITextField *passF;
@property (weak, nonatomic) IBOutlet UIButton *registB;
@end

@implementation ToFaceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.title = @"面对面开通账号";
    self.bottomView.hidden = YES;
    [self setUI];

}

- (void)setUI{
    
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"请输入手机号" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#BCBCBC"],NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    self.phoneF.attributedPlaceholder = attrString;
    
    NSAttributedString *attrString1 = [[NSAttributedString alloc] initWithString:@"请输入验证码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#BCBCBC"],NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    self.yanF.attributedPlaceholder = attrString1;
    
    
    NSAttributedString *attrString3 = [[NSAttributedString alloc] initWithString:@"输入登陆密码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#BCBCBC"],NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    self.passF.attributedPlaceholder = attrString3;
    
    self.registB.layer.cornerRadius = 22;
    self.registB.layer.masksToBounds = YES;

}

- (IBAction)doneAC:(id)sender {
}



@end
