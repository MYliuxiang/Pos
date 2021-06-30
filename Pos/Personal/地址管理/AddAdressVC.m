//
//  AddAdressVC.m
//  Pos
//
//  Created by 刘翔 on 2021/6/27.
//

#import "AddAdressVC.h"

@interface AddAdressVC ()
@property (weak, nonatomic) IBOutlet UIButton *doneB;
@property (weak, nonatomic) IBOutlet UITextField *nameF;
@property (weak, nonatomic) IBOutlet UITextField *phoneF;
@property (weak, nonatomic) IBOutlet UITextField *addressF;
@property (weak, nonatomic) IBOutlet UITextView *addressDetailT;
@property (nonatomic, copy) NSArray <NSString *> *addressSelectValues;
@property (nonatomic, copy) NSString  *districtCode;


@end

@implementation AddAdressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if(self.model == nil){
        self.customNavBar.title = @"添加新地址";
    }else{
        self.customNavBar.title = @"编辑加新地址";
        self.nameF.text = self.model.name;
        self.phoneF.text = self.model.phone;
        self.addressF.text = [NSString stringWithFormat:@"%@%@%@",self.model.procName,self.model.cityName,self.model.districtName];
        self.addressDetailT.text = self.model.addrDetail;
        self.addressSelectValues = @[self.model.procName,self.model.cityName,self.model.districtName];
        self.districtCode = self.model.districtCode;
    }
    
    LXViewBorder(self.doneB, 22);
    
}


- (IBAction)doneAC:(id)sender {
    
    if (self.nameF.text.length == 0) {
        [MBProgressHUD showError:@"请输入收货人姓名！" toView:self.view];
        return;
    }
    if (self.phoneF.text.length != 11) {
        [MBProgressHUD showError:@"输入的电话号码不正确，请重新输入！" toView:self.view];
        return;
    }
    if (self.addressF.text.length == 0) {
        [MBProgressHUD showError:@"请选择所在区域！" toView:self.view];
        return;
    }
    if (self.addressDetailT.text.length == 0) {
        [MBProgressHUD showError:@"请输入街道，楼牌号！" toView:self.view];
        return;
    }
    
    if (self.model != nil) {
        BADataEntity *entity = [BADataEntity new];
        entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_address];
        entity.needCache = NO;
        entity.parameters = @{@"addrDetail":self.addressDetailT.text,@"cityName":self.addressSelectValues
                              [1],@"districtCode":self.districtCode,@"districtName":self.addressSelectValues
                              [2],@"name":self.nameF.text,@"phone":self.phoneF.text,@"procName":self.addressSelectValues
                              [0],@"id":self.model.aid};
        [MBProgressHUD showHUDAddedTo:lxMbProgressView animated:YES];
        [BANetManager ba_request_PUTWithEntity:entity successBlock:^(id response) {
            NSDictionary *result = response;
            if ([result[@"code"] intValue] == 200) {
                
                if (self.addBlock) {
                    self.addBlock();
                }
                [self.navigationController popViewControllerAnimated:YES];
            }
         
            
            
        } failureBlock:^(NSError *error) {
            
        } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
            
        }];
    }else{
        BADataEntity *entity = [BADataEntity new];
        entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_address];
        entity.needCache = NO;
        entity.parameters = @{@"addrDetail":self.addressDetailT.text,@"cityName":self.addressSelectValues
                              [1],@"districtCode":self.districtCode,@"districtName":self.addressSelectValues
                              [2],@"name":self.nameF.text,@"phone":self.phoneF.text,@"procName":self.addressSelectValues
                              [0]};
        [MBProgressHUD showHUDAddedTo:lxMbProgressView animated:YES];
        [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
            NSDictionary *result = response;
            if ([result[@"code"] intValue] == 200) {
                
                if (self.addBlock) {
                    self.addBlock();
                }
                [self.navigationController popViewControllerAnimated:YES];
            }
         
            
            
        } failureBlock:^(NSError *error) {
            
        } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
            
        }];
        
        
    }
    
   
}




- (void)seletedAdress{
    // 地区
    
    LXAddressPickeView *addressPickerView = [[LXAddressPickeView alloc]init];
    addressPickerView.pickerMode = BRAddressPickerModeArea;
    addressPickerView.title = @"请选择所在区域";
    addressPickerView.selectValues = self.addressSelectValues;
//    addressPickerView.isAutoSelect = YES;
    addressPickerView.resultBlock = ^(BRProvinceModel *province, BRCityModel *city, BRAreaModel *area) {
        self.addressSelectValues = @[province.name, city.name,area.name];
        self.districtCode = area.code;
        self.addressF.text = [NSString stringWithFormat:@"%@ %@ %@", province.name, city.name, area.name];;
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
    if(textField == self.addressF){
        [self seletedAdress];
        return  NO;
    }
    
    return YES;
   
}



@end
