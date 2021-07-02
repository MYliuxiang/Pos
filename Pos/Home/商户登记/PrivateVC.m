//
//  PrivateVC.m
//  Pos
//
//  Created by 刘翔 on 2021/6/25.
//

#import "PrivateVC.h"

@interface PrivateVC ()
@property (weak, nonatomic) IBOutlet UIButton *doneB;
@property (weak, nonatomic) IBOutlet UILabel *startTime1L;
@property (weak, nonatomic) IBOutlet UILabel *endTime1L;
@property (weak, nonatomic) IBOutlet UILabel *startTime2L;
@property (weak, nonatomic) IBOutlet UILabel *endTime2L;
@property (weak, nonatomic) IBOutlet UIButton *companyTypeB;
@property (weak, nonatomic) IBOutlet UITextField *aderssF;
@property (copy, nonatomic) NSArray *companyTypes;
@property (nonatomic, copy) NSArray <NSNumber *> *addressSelectIndexs;
@end

@implementation PrivateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.hidden = YES;
    LXViewBorder(self.doneB, 22)

    self.companyTypes = @[@"特殊进件",@"企业进件",@"个体工商户进件"];
    [self setUI];

    
}

- (void)setUI{
    
    /** NSDate 转 NSString */
    NSString *timeStr = [NSDate br_stringFromDate:[NSDate date] dateFormat:@"yyyy-MM-dd"];
    self.startTime1L.text = timeStr;
    self.startTime2L.text = timeStr;
    self.endTime1L.text = timeStr;
    self.endTime2L.text = timeStr;
    

    
    
}




- (IBAction)startTimeAC:(UITapGestureRecognizer *)sender {
    
    UILabel *timeL = (UILabel *)sender.view;
    
    BRDatePickerView *datePickerView = [[BRDatePickerView alloc]init];
    datePickerView.pickerMode = BRDatePickerModeYMD;
    datePickerView.title = @"请选择开始日期";
    datePickerView.selectDate = [NSDate br_dateFromString:timeL.text dateFormat:@"yyyy-MM-dd"];
    datePickerView.minDate = [NSDate br_setYear:1900 month:1 day:1];
    datePickerView.maxDate = [NSDate br_setYear:2100 month:1 day:1];
    datePickerView.isAutoSelect = YES;
    datePickerView.monthNames = @[@"一月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月", @"九月", @"十月", @"十一月", @"十二月"];
    datePickerView.keyView = self.view; // 将组件 datePickerView 添加到 self.view 上，默认是添加到 keyWindow 上
    datePickerView.resultBlock = ^(NSDate *selectDate, NSString *selectValue) {
       
        timeL.text = selectValue;
        
    };
      
    BRPickerStyle *customStyle = [[BRPickerStyle alloc]init];
    customStyle.pickerColor = [UIColor whiteColor];
    customStyle.selectRowTextColor = [UIColor colorWithHexString:@"#FF8901"];
    customStyle.cancelBtnTitle = @"取消";
    customStyle.doneBtnTitle = @"确认";
    datePickerView.pickerStyle = customStyle;
    [datePickerView show];
}

- (IBAction)endTimeAC:(UITapGestureRecognizer *)sender {
    
    UILabel *timeL = (UILabel *)sender.view;
    
    BRDatePickerView *datePickerView = [[BRDatePickerView alloc]init];
    datePickerView.pickerMode = BRDatePickerModeYMD;
    datePickerView.title = @"请选择结束日期";
    datePickerView.selectDate = [NSDate br_dateFromString:timeL.text dateFormat:@"yyyy-MM-dd"];
    datePickerView.minDate = [NSDate br_setYear:1900 month:1 day:1];
    datePickerView.maxDate = [NSDate br_setYear:2100 month:1 day:1];
//    datePickerView.isAutoSelect = YES;
    datePickerView.monthNames = @[@"一月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月", @"九月", @"十月", @"十一月", @"十二月"];
    datePickerView.keyView = self.view; // 将组件 datePickerView 添加到 self.view 上，默认是添加到 keyWindow 上
    datePickerView.resultBlock = ^(NSDate *selectDate, NSString *selectValue) {
        timeL.text = selectValue;
    };
      
    BRPickerStyle *customStyle = [[BRPickerStyle alloc]init];
    customStyle.pickerColor = [UIColor whiteColor];
    customStyle.selectRowTextColor = [UIColor colorWithHexString:@"#FF8901"];
    customStyle.cancelBtnTitle = @"取消";
    customStyle.doneBtnTitle = @"确认";
    datePickerView.pickerStyle = customStyle;
    [datePickerView show];
}

- (IBAction)companyTypeAC:(id)sender {
    
    // 性别
    BRStringPickerView *stringPickerView = [[BRStringPickerView alloc]init];
    stringPickerView.pickerMode = BRStringPickerComponentSingle;
    stringPickerView.title = @"请进件类型";
    stringPickerView.dataSourceArr = self.companyTypes;
    stringPickerView.selectValue = self.companyTypeB.titleLabel.text ;
    stringPickerView.resultModelBlock = ^(BRResultModel *resultModel) {
        [self.companyTypeB setTitle:resultModel.value forState:UIControlStateNormal];
    };
    
    BRPickerStyle *customStyle = [[BRPickerStyle alloc]init];
    customStyle.pickerColor = [UIColor whiteColor];
    customStyle.selectRowTextColor = [UIColor colorWithHexString:@"#FF8901"];
    customStyle.cancelBtnTitle = @"取消";
    customStyle.doneBtnTitle = @"确认";
    stringPickerView.pickerStyle = customStyle;
    [stringPickerView show];
    
}

- (void)seletedAdress{
    // 地区
    LXAddressPickeView *addressPickerView = [[LXAddressPickeView alloc]init];
    addressPickerView.pickerMode = BRAddressPickerModeArea;
    addressPickerView.title = @"请选择商户地址";
    addressPickerView.selectIndexs = self.addressSelectIndexs;
//    addressPickerView.isAutoSelect = YES;
    addressPickerView.resultBlock = ^(BRProvinceModel *province, BRCityModel *city, BRAreaModel *area) {
        self.addressSelectIndexs = @[@(province.index), @(city.index), @(area.index)];
        self.aderssF.text = [NSString stringWithFormat:@"%@ %@ %@", province.name, city.name, area.name];;
    };
    
    BRPickerStyle *customStyle = [[BRPickerStyle alloc]init];
    customStyle.pickerColor = [UIColor whiteColor];
    customStyle.selectRowTextColor = [UIColor colorWithHexString:@"#FF8901"];
    customStyle.cancelBtnTitle = @"取消";
    customStyle.doneBtnTitle = @"确认";
    addressPickerView.pickerStyle = customStyle;
    [addressPickerView show];
    
    
    
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if(textField == self.aderssF){
        [self seletedAdress];
        return  NO;
    }
    
    return YES;
   
}


#pragma mark - JXCategoryListContentViewDelegate
/**
 实现 <JXCategoryListContentViewDelegate> 协议方法，返回该视图控制器所拥有的「视图」
 */
- (UIView *)listView {
    return self.view;
}

- (IBAction)photoAC:(UIButton *)sender {
    
    TZImgePickHelper *helper = [[TZImgePickHelper alloc] initMaxCount:1];
    helper.didFinishPickingPhotosHandle = ^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
//        [self uploadIcon:photos[0]];
        UIImage *image = photos[0];
        NSData *imageData = UIImageJPEGRepresentation(image, 1);
        OSSPutObjectRequest *put = [OSSPutObjectRequest new];

        // 填写Bucket名称，例如examplebucket。
        put.bucketName = @"examplebucket";
        // 填写文件完整路径，例如exampledir/exampleobject.txt。Object完整路径中不能包含Bucket名称。
        put.objectKey = @"exampledir/exampleobject.txt";
//        put.uploadingFileURL = [NSURL fileURLWithPath:@"<filePath>"];
         put.uploadingData = imageData; // 直接上传NSData。

        // （可选）设置上传进度。
        put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
            // 指定当前上传长度、当前已经上传总长度、待上传的总长度。
            NSLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
        };
        // 配置可选字段。
        // put.contentType = @"application/octet-stream";
        // put.contentMd5 = @"";
        // put.contentEncoding = @"";
        // put.contentDisposition = @"";
        // 可以在上传文件时设置文件元数据或者HTTP头部。
        // put.objectMeta = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"value1", @"x-oss-meta-name1", nil];
        
        NSString *endPoint = @"http://oss-cn-hangzhou.aliyuncs.com";
        // 由阿里云颁发的AccessKeyId/AccessKeySecret构造一个CredentialProvider。
        // 移动端建议使用STS方式初始化OSSClient。
        id<OSSCredentialProvider> credential = [[OSSFederationCredentialProvider alloc] initWithFederationTokenGetter:^OSSFederationToken * _Nullable{
            OSSFederationToken *token = [OSSFederationToken new];
            // 从STS服务获取的临时访问密钥（AccessKey ID和AccessKey Secret）。
            token.tAccessKey = @"AccessKeyId";
            token.tSecretKey = @"AccessKeySecret";
            // 从STS服务获取的安全令牌（SecurityToken）。
            token.tToken = @"SecurityToken";
            // 临时访问凭证的过期时间。
            token.expirationTimeInGMTFormat = @"Expiration";
            return token;
        }];

        OSSClientConfiguration * conf = [OSSClientConfiguration new];
        conf.maxRetryCount = 3; // 网络请求遇到异常失败后的重试次数
        conf.timeoutIntervalForRequest = 30; // 网络请求的超时时间
        conf.timeoutIntervalForResource = 24 * 60 * 60; // 允许资源传输的最长时间
        OSSClient *client = [[OSSClient alloc] initWithEndpoint:endPoint credentialProvider:credential clientConfiguration:conf];
                
        OSSTask *putTask = [client putObject:put];
        [putTask continueWithBlock:^id(OSSTask *task) {
            if (!task.error) {
                NSLog(@"upload object success!");
            } else {
                NSLog(@"upload object failed, error: %@" , task.error);
            }
            return nil;
        }];
        
        
    };
    [self presentViewController:helper animated:YES completion:nil];
    
}



- (IBAction)doneAC:(id)sender {
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@to_private",MainUrl,Url_merc];
    entity.needCache = NO;
    [MBProgressHUD showHUDAddedTo:lxMbProgressView animated:YES];
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 200){
            
         
           
        }
    } failureBlock:^(NSError *error) {

    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}

@end
