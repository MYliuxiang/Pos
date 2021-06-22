//
//  AboutusVCViewController.m
//  Pos
//
//  Created by 李立 on 2021/6/22.
//

#import "AboutusVCViewController.h"

@interface AboutusVCViewController ()

@end

@implementation AboutusVCViewController

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
    titlelabel.text = @"关于我们";
    [self.view addSubview:titlelabel];
    
    //背景视图
    UIView *witreview = [[UIView alloc]initWithFrame:CGRectMake(0, [self ykNavigationbarAndTopHeight]+20, kScreenWidth, 309)];
    witreview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:witreview];
    
    //标题
    self.titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 24, kScreenWidth, 21)];
    self.titlelabel.font = [UIFont systemFontOfSize:16];
    self.titlelabel.textAlignment = NSTextAlignmentCenter;
    self.titlelabel.text = @"支付伙伴";
    [witreview addSubview:self.titlelabel];
    
    //内容
    self.contelabel = [[UILabel alloc]initWithFrame:CGRectMake(39, self.titlelabel.bottom+24, kScreenWidth-39*2, 0)];
    self.contelabel.textColor = [UIColor colorWithHexString:@"B0B0B0"];
    self.contelabel.numberOfLines = 0;
    self.contelabel.font = [UIFont systemFontOfSize:14];
    [witreview addSubview:self.contelabel];
    NSString *contersring = @"   公司的相关介绍公司的相关介绍，公司的相关介绍公司的相关介绍公司的相关介绍公司的相关介绍公司的相关介绍公司的相关介绍公司的相关介绍，公司的相关介绍公司的相关介绍，公司的相关介绍公司的相关介绍，公司的相关介绍公司的相关介绍。";
    CGSize baseSize = CGSizeMake(kScreenWidth-39*2, CGFLOAT_MAX);
    CGSize labelsize  = [contersring
                        boundingRectWithSize:baseSize
                        options:NSStringDrawingUsesLineFragmentOrigin
                        attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]}
                        context:nil].size;
    self.contelabel.text = contersring;
    self.contelabel.height = labelsize.height;
}

@end
