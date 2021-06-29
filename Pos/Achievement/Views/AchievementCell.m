//
//  AchievementCell.m
//  Pos
//
//  Created by tenvine on 2021/6/24.
//

#import "AchievementCell.h"

@implementation AchievementCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bgView.layer.cornerRadius=10;
    self.bgView.layer.shadowColor=[UIColor blackColor].CGColor;
    self.bgView.layer.shadowOffset=CGSizeMake(5, 5);
    self.bgView.layer.shadowOpacity=0.3;
    self.bgView.layer.shadowRadius=5;
    
    CGRect rect = CGRectMake(0, 0, (kScreenWidth - 31) / 2, ((kScreenWidth - 30) / 403 * 225 - 1) / 2);
    UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerTopLeft  cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc]init];
    maskLayer1.frame = rect;
    maskLayer1.path = maskPath1.CGPath;
    self.view1.layer.mask = maskLayer1;
    
    UIBezierPath *maskPath2 = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerTopRight  cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer2 = [[CAShapeLayer alloc]init];
    maskLayer2.frame = rect;
    maskLayer2.path = maskPath2.CGPath;
    self.view2.layer.mask = maskLayer2;
    
    UIBezierPath *maskPath3 = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerBottomLeft  cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer3 = [[CAShapeLayer alloc]init];
    maskLayer3.frame = rect;
    maskLayer3.path = maskPath3.CGPath;
    self.view3.layer.mask = maskLayer3;
    
    UIBezierPath *maskPath4 = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerBottomRight  cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer4 = [[CAShapeLayer alloc]init];
    maskLayer4.frame = rect;
    maskLayer4.path = maskPath4.CGPath;
    self.view4.layer.mask = maskLayer4;
  
}



- (void)layoutSubviews{
    [super layoutSubviews];
    
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(AchievementModel *)model
{
    _model = model;
    self.number1L.text = model.serviceTradingMoney;
    self.number2L.text = model.serviceAddSum;
    self.number3L.text = model.personalTradingMoney;
    self.number4L.text = model.personalAddSum;
    self.timeL.text = model.time;
}

@end
