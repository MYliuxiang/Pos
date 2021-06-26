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
@property (nonatomic, copy) NSArray <NSNumber *> *addressSelectIndexs;

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
        self.addressF.text = self.model.adress;
        self.addressDetailT.text = self.model.adressDetail;
    }
    
    LXViewBorder(self.doneB, 22);
    
}


- (IBAction)doneAC:(id)sender {
    
    if (self.nameF.text.length == 0) {
        [MBProgressHUD showError:@"请输入收货人姓名" toView:self.view];
        return;
    }
    if (self.phoneF.text.length == 0) {
        [MBProgressHUD showError:@"请输入收货人姓名" toView:self.view];
        return;
    }
    if (self.addressF.text.length == 0) {
        [MBProgressHUD showError:@"请输入收货人姓名" toView:self.view];
        return;
    }
    if (self.addressDetailT.text.length == 0) {
        [MBProgressHUD showError:@"请输入收货人姓名" toView:self.view];
        return;
    }
    
    AdressModel *model = [[AdressModel alloc] init];
    model.name = self.nameF.text;
    model.phone = self.phoneF.text;
    model.adress = self.addressF.text;
    model.adressDetail = self.addressDetailT.text;
    
    if (self.addBlock != nil) {
        self.addBlock(model);
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)seletedAdress{
    // 地区
    BRAddressPickerView *addressPickerView = [[BRAddressPickerView alloc]init];
    addressPickerView.pickerMode = BRAddressPickerModeArea;
    addressPickerView.title = @"请选择所在区域";
    addressPickerView.selectIndexs = self.addressSelectIndexs;
//    addressPickerView.isAutoSelect = YES;
    addressPickerView.resultBlock = ^(BRProvinceModel *province, BRCityModel *city, BRAreaModel *area) {
        self.addressSelectIndexs = @[@(province.index), @(city.index), @(area.index)];
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
