//
//  TerminalTransfTwoVC.m
//  Pos
//
//  Created by tenvine on 2021/6/21.
//

#import "TerminalTransfTwoVC.h"
#import "WBQRCodeVC.h"


@interface TerminalTransfTwoVC ()
@property (nonatomic, copy) void(^scrollCallback)(UIScrollView *scrollView);
@property (strong, nonatomic) IBOutlet UIView *sectionHeader;
@property (weak, nonatomic) IBOutlet UITextField *text1F;
@property (weak, nonatomic) IBOutlet UITextField *text2F;
@property (weak, nonatomic) IBOutlet UILabel *bottomL;
@property (weak, nonatomic) IBOutlet UIButton *tansfB;
@end

@implementation TerminalTransfTwoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.hidden = YES;
    
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"请选择开始终端号" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#B5B5B5"],NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    self.text1F.attributedPlaceholder = attrString;
    
    NSAttributedString *attrString1 = [[NSAttributedString alloc] initWithString:@"请选择结束终端号" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#B5B5B5"],NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    self.text2F.attributedPlaceholder = attrString1;
    
    self.tableView.allowsMultipleSelection = YES;
    self.tansfB.layer.cornerRadius = 22;
    self.tansfB.layer.masksToBounds = YES;

}

- (IBAction)tansfAC:(id)sender {
}

- (IBAction)scanAC:(UIButton *)sender {
    
    NSInteger tag = sender.tag;
    
    WBQRCodeVC *scanVC = [WBQRCodeVC new];
    scanVC.reslutBlock = ^(NSString *resultStr) {
        if (resultStr.length != 0) {
            
           
        }
    };
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        switch (status) {
                case AVAuthorizationStatusNotDetermined: {
                    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                        if (granted) {
                            dispatch_sync(dispatch_get_main_queue(), ^{
                           
                                
                                [self.navigationController pushViewController:scanVC animated:YES];
                            });
                            NSLog(@"用户第一次同意了访问相机权限 - - %@", [NSThread currentThread]);
                        } else {
                            NSLog(@"用户第一次拒绝了访问相机权限 - - %@", [NSThread currentThread]);
                        }
                    }];
                    break;
                }
                case AVAuthorizationStatusAuthorized: {
                    [self.navigationController pushViewController:scanVC animated:YES];
                    break;
                }
                case AVAuthorizationStatusDenied: {
                    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请去-> [设置 - 隐私 - 相机 - SGQRCodeExample] 打开访问开关" preferredStyle:(UIAlertControllerStyleAlert)];
                    UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                        
                    }];
                    
                    [alertC addAction:alertA];
                    [self presentViewController:alertC animated:YES completion:nil];
                    break;
                }
                case AVAuthorizationStatusRestricted: {
                    NSLog(@"因为系统原因, 无法访问相册");
                    break;
                }
                
            default:
                break;
        }
        return;
    }
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"未检测到您的摄像头" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertC addAction:alertA];
    [self presentViewController:alertC animated:YES completion:nil];
    
}

#pragma  mark --------UITableView Delegete----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifire = @"cellID";
    TransfCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TransfCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 118;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return self.sectionHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}




- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    !self.scrollCallback ?: self.scrollCallback(scrollView);
}

#pragma mark - JXPagingViewListViewDelegate

- (UIView *)listView {
    return self.view;
}

- (UIScrollView *)listScrollView {
    return self.tableView;
}

- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    self.scrollCallback = callback;
}

- (void)listWillAppear {
    NSLog(@"2:%@", NSStringFromSelector(_cmd));
}

- (void)listDidAppear {
    NSLog(@"2:%@", NSStringFromSelector(_cmd));
}

- (void)listWillDisappear {
    NSLog(@"2:%@", NSStringFromSelector(_cmd));
}

- (void)listDidDisappear {
    NSLog(@"2:%@", NSStringFromSelector(_cmd));
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
