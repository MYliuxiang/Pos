//
//  AddcariphoneVC.m
//  Pos
//
//  Created by 李立 on 2021/6/27.
//

#import "AddcariphoneVC.h"

@interface AddcariphoneVC ()

@end

@implementation AddcariphoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUI];
}

//初始化视图
-(void)setUI{
    UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, [self ykStatusbarHeight]+12, kScreenWidth, 21)];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    titlelabel.font = [UIFont boldSystemFontOfSize:16];
    titlelabel.text = @"新增银行卡";
    [self.view addSubview:titlelabel];
    
    //请先绑定本人的手机号
    UILabel *addiphonelabel = [[UILabel alloc]initWithFrame:CGRectMake(21, [self ykNavigationbarAndTopHeight]+20, 200, 19)];
    addiphonelabel.font = [UIFont boldSystemFontOfSize:14];
    addiphonelabel.text = @"请绑定本人的手机号";
    [self.view addSubview:addiphonelabel];
    
    //白色背景
    UIView *baiseview = [[UIView alloc]initWithFrame:CGRectMake(0, addiphonelabel.bottom+10, kScreenWidth, 122)];
    baiseview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:baiseview];
    
    //手机号
    UILabel *iphonelabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 25, 60, 19)];
    iphonelabel.font = [UIFont boldSystemFontOfSize:14];
    iphonelabel.text = @"手机号";
    [baiseview addSubview:iphonelabel];
    
    //手机号码
    self.iphonetextfield = [[UITextField alloc]initWithFrame:CGRectMake(iphonelabel.right+40, 25, 200, 19)];
    self.iphonetextfield.font = [UIFont systemFontOfSize:14];
    self.iphonetextfield.placeholder = @"请输入手机号";
    [baiseview addSubview:self.iphonetextfield];
    
    //线条
    UIView *xtview = [[UIView alloc]initWithFrame:CGRectMake(27, iphonelabel.bottom+18, kScreenWidth, 1)];
    xtview.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
    [baiseview addSubview:xtview];
    
    //验证码
    UILabel *yzmlabel = [[UILabel alloc]initWithFrame:CGRectMake(20, xtview.bottom+22, 60, 19)];
    yzmlabel.font = [UIFont boldSystemFontOfSize:14];
    yzmlabel.text = @"验证码";
    [baiseview addSubview:yzmlabel];
    
    //手机号码
    self.yzmtextfield = [[UITextField alloc]initWithFrame:CGRectMake(yzmlabel.right+40,yzmlabel.top, 200, 19)];
    self.yzmtextfield.font = [UIFont systemFontOfSize:14];
    self.yzmtextfield.placeholder = @"请输入验证码";
    [baiseview addSubview:self.yzmtextfield];
    
    //信息采集
    UILabel *bottomlabel = [[UILabel alloc]initWithFrame:CGRectMake(30, baiseview.bottom+10, kScreenWidth-60, 80)];
    bottomlabel.textColor = [UIColor colorWithHexString:@"#BDBDBD"];
    bottomlabel.numberOfLines = 0;
    bottomlabel.text = @"信息采集提示：我们会收集您银行卡的开户名称，卡号，卡类型，与发卡银行进行验证，确保是您本人的银行卡。";
    [self.view addSubview:bottomlabel];
    
    //下一步按钮
    UIButton *nextbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextbutton.frame = CGRectMake((kScreenWidth-335)/2, kScreenHeight-85, 335, 44);
    KViewBorderRadius(nextbutton, 22, 0.5, [UIColor clearColor]);
    nextbutton.backgroundColor = [UIColor colorWithHexString:@"#FF8901"];
    [nextbutton setTitle:@"下一步" forState:UIControlStateNormal];
    [nextbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextbutton addTarget:self action:@selector(nextbuttonaciton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextbutton];
    
}


//下一步
-(void)nextbuttonaciton{
    
    
}

@end
