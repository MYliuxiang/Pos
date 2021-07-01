//
//  TerSearchCell.m
//  Pos
//
//  Created by tenvine on 2021/6/24.
//

#import "TerSearchCell.h"

@implementation TerSearchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(TerminalModel *)model
{
    _model = model;
    self.nameL.text = model.modelName;
    self.numberL.text = model.deviceNo;
    NSString *bindStr;
    if (model.bindStatus == 0) {
        bindStr = @"未绑定";
    }else{
        bindStr = @"已绑定";

    }
    
    NSString *cashbackStr;
    if (model.cashbackStatus == 0) {
        cashbackStr = @"未返现";
    }else{
        cashbackStr = @"已返现";
    }
    
    self.statusL.text = [NSString stringWithFormat:@"%@  .  %@",bindStr,cashbackStr];
    
}

@end
