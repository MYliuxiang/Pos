//
//  InvitationVC.m
//  Pos
//
//  Created by tenvine on 2021/6/22.
//

#import "InvitationVC.h"
#import "PosterVC.h"

@interface InvitationVC ()
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation InvitationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.title = @"邀请加入";
    self.bottomView.hidden = YES;
    self.rightTitle = @"选择花样海报";
    self.rightColor = [UIColor colorWithHexString:@"#A2A2A2"];
    
    self.bgView.layer.cornerRadius=10;
    self.bgView.layer.shadowColor=[UIColor blackColor].CGColor;
    self.bgView.layer.shadowOffset=CGSizeMake(5, 5);
    self.bgView.layer.shadowOpacity=0.3;
    self.bgView.layer.shadowRadius=5;
    
    
}

- (void)doRightNavBarRightBtnAction{
    
    PosterVC *vc = [PosterVC new];
    [self.navigationController pushViewController:vc animated:YES];
    
}



@end
