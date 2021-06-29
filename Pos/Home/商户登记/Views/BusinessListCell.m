//
//  BusinessListCell.m
//  Pos
//
//  Created by 刘翔 on 2021/6/23.
//

#import "BusinessListCell.h"

@implementation BusinessListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(MerchantModel *)model{
    _model = model;
    self.nameL.text = model.mercName;
    self.phoneL.text = model.mercPhone;
    self.numberL.text = model.deviceNo;
}

@end
