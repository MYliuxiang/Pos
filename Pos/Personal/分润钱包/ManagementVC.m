//
//  ManagementVC.m
//  Pos
//
//  Created by 李立 on 2021/6/27.
//

#import "ManagementVC.h"

@interface ManagementVC ()

@end

@implementation ManagementVC

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
    titlelabel.text = @"管理奖";
    [self.view addSubview:titlelabel];
}


@end
