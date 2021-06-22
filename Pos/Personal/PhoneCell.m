//
//  PhoneCell.m
//  HMOnlineRetailers
//
//  Created by 李立 on 2021/1/12.
//  Copyright © 2021 luopinchao. All rights reserved.
//

#import "PhoneCell.h"

@implementation PhoneCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //        self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
        [self setui];
//        [self creatViews];
    }
    return self;
}


//初始化视图
-(void)setui{
   
    //选择照片
    _imageview =[[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 74, 74)];
    _imageview.backgroundColor = [UIColor redColor];
    _imageview.image =[UIImage imageNamed:@"添加照片"];
    [self addSubview:_imageview];
    
    //删除按钮
    _delectbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    _delectbutton.frame = CGRectMake(_imageview.width-3, _imageview.top-7, 30, 30);
    _delectbutton.hidden = YES;
    [_delectbutton setImage:[UIImage imageNamed:@"照片删除"] forState:UIControlStateNormal];
    
    [_delectbutton addTarget:self action:@selector(delectbuttonaciton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_delectbutton];
    
    
}


//删除按钮
-(void)delectbuttonaciton:(UIButton *)button{
//    if (self.phonecellDelegate && [self.phonecellDelegate respondsToSelector:@selector(delectimage:)])
//     {
//     // 调用代理方法
//     [self.phonecellDelegate delectimage:self.model];
//     }
}


//-(void)setimagearry:(PhoneModel *)model{
//    self.model =model;
//    if (model.image ==nil) {
//        if ([model.imageid isEqualToString:@"隐藏"]) {
//            _delectbutton.hidden = YES;
//            _imageview.hidden = YES;
//        }else{
//        _imageview.image =[UIImage imageNamed:@"添加照片"];
//            _delectbutton.hidden = YES;
//            _imageview.hidden = NO;
//        }
//    }else{
//        _imageview.image = model.image;
//        _delectbutton.hidden = NO;
//        _imageview.hidden = NO;
//    }
//    
//}
@end
