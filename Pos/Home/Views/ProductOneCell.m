//
//  ProductOneCell.m
//  Pos
//
//  Created by 刘翔 on 2021/6/22.
//

#import "ProductOneCell.h"

@implementation ProductOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.field = [[GHCountField alloc] init];
    self.field.minCount = 1;
    self.field.maxCount = 100;
    self.field.count = 1;
    [self.contentView addSubview:self.field];
    [self.field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.contentView).offset(-20);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(120);
    }];
    [self.field.leftButton setImage:[UIImage imageNamed:@"减_可操作icon"] forState:UIControlStateNormal];
    [self.field.leftButton setImage:[UIImage imageNamed:@"减_icon"] forState:UIControlStateDisabled];
    [self.field.rightButton setImage:[UIImage imageNamed:@"加_可操作_icon"] forState:UIControlStateNormal];
    [self.field.rightButton setImage:[UIImage imageNamed:@"加_icon"] forState:UIControlStateDisabled];

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
