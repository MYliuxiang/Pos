//
//  RegistReslutVC.m
//  Pos
//
//  Created by 刘翔 on 2021/6/20.
//

#import "RegistReslutVC.h"

@interface RegistReslutVC ()
@property (weak, nonatomic) IBOutlet UIButton *resultB;

@end

@implementation RegistReslutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.hidden = YES;
    self.resultB.layer.cornerRadius = 22;
    self.resultB.layer.masksToBounds = YES;
    self.fd_interactivePopDisabled = NO;
}

- (IBAction)goLoginAC:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
