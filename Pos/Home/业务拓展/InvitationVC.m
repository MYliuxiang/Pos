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
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *phoneL;
@property (weak, nonatomic) IBOutlet UILabel *invationL;
@property (weak, nonatomic) IBOutlet UIImageView *bgImg;
@property (weak, nonatomic) IBOutlet UIImageView *qrCodeImg;
@property (nonatomic, copy) NSString *invitionStr;
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
    self.bgView.hidden = YES;
    [self loadData];
        
    
}

- (void)loadData{
    
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_user_userAppInfo];
    entity.needCache = NO;
    [MBProgressHUD showHUDAddedTo:lxMbProgressView animated:YES];
    [BANetManager ba_request_GETWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 200) {
            self.bgView.hidden = NO;
            self.nameL.text = result[@"data"][@"name"];
            self.phoneL.text = result[@"data"][@"phone"];
            self.invationL.text = result[@"data"][@"invitationCode"];
            self.invitionStr = [NSString stringWithFormat:@"%@%@?invitationCode=%@",H5MainUrl,H5_register,result[@"data"][@"invitationCode"]];
            self.qrCodeImg.image = [SGQRCodeObtain generateQRCodeWithData:self.invitionStr size:kScreenWidth - 124];


        }
    } failureBlock:^(NSError *error) {
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
    
    
}

- (void)doRightNavBarRightBtnAction{
    
    PosterVC *vc = [PosterVC new];
    vc.seltedBlock = ^(PosterModel * _Nonnull model) {
        [self.bgImg sd_setImageWithURL:[NSURL URLWithString:model.background]];
    };
    [self.navigationController pushViewController:vc animated:YES];
    
}



@end
