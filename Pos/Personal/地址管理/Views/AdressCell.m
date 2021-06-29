//
//  AdressCell.m
//  Pos
//
//  Created by 刘翔 on 2021/6/27.
//

#import "AdressCell.h"

@implementation AdressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(AdressModel *)model
{
    _model = model;
    self.nameL.text = model.name;
    self.phoneL.text = model.phone;
    self.adressL.text = [NSString stringWithFormat:@"%@%@%@%@",model.procName,model.cityName,model.districtName,model.addrDetail];
    if (model.defaultValue) {
        [self.defaultB setImage:[UIImage imageNamed:@"组 20"] forState:UIControlStateNormal];
    }else{
        [self.defaultB setImage:[UIImage imageNamed:@"矩形 216"] forState:UIControlStateNormal];
    }
}

@end
