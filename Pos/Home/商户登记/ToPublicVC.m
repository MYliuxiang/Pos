//
//  ToPublicVC.m
//  Pos
//
//  Created by 刘翔 on 2021/6/25.
//

#import "ToPublicVC.h"

@interface ToPublicVC ()
@property (weak, nonatomic) IBOutlet UIButton *doneB;
@property (copy, nonatomic) NSArray *companyTypes;
@property (weak, nonatomic) IBOutlet UILabel *startTime1L;
@property (weak, nonatomic) IBOutlet UILabel *endTime1L;
@property (weak, nonatomic) IBOutlet UILabel *startTime2L;
@property (weak, nonatomic) IBOutlet UILabel *endTime2L;
@property (weak, nonatomic) IBOutlet UITextField *adressF;
@property (weak, nonatomic) IBOutlet UIButton *companyTypeB;
@property (nonatomic, copy) NSArray <NSNumber *> *addressSelectIndexs;

@end

@implementation ToPublicVC

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
        self.adressF.text = [NSString stringWithFormat:@"%@ %@ %@", province.name, city.name, area.name];;
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
    if(textField == self.adressF){
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

- (IBAction)doneAC:(id)sender {
    
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@to_public",MainUrl,Url_merc];
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
