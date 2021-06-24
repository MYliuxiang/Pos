//
//  ALeftCell.m
//  Pos
//
//  Created by tenvine on 2021/6/24.
//

#import "ALeftCell.h"

@implementation ALeftCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    CGRect rect = CGRectMake(0, 0, 90, 42);

    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerTopLeft  cornerRadii:CGSizeMake(21, 21)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = rect;
    maskLayer.path = maskPath.CGPath;
    self.bgView.layer.mask = maskLayer;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
    if (selected) {
        self.titleL.textColor = [UIColor colorWithHexString:@"#FF8901"];
        self.bgView.hidden = NO;
    }else{
        self.titleL.textColor = [UIColor colorWithHexString:@"#232323"];
        self.bgView.hidden = YES;

    }
}

@end
