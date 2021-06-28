//
//  TransfCCell.m
//  Pos
//
//  Created by tenvine on 2021/6/21.
//

#import "TransfCCell.h"

@implementation TransfCCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setSelected:(BOOL)selected{

    if (selected) {
        self.seletedI.hidden = NO;
    }else{
        self.seletedI.hidden = YES;
    }
}

- (void)setModel:(BrandModel *)model
{
    _model = model;
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.brandImg]];
    self.titleL.text = model.brandName;
}

@end
