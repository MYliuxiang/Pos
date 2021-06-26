//
//  AdressVC.m
//  Pos
//
//  Created by 刘翔 on 2021/6/27.
//

#import "AdressVC.h"

@interface AdressVC ()

@end

@implementation AdressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if(self.type == AdressTypeMange){
        self.customNavBar.title = @"管理收货地址";
    }else{
        self.customNavBar.title = @"选择收货地址";

    }
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
