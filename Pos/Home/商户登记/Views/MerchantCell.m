//
//  MerchantCell.m
//  Pos
//
//  Created by 刘翔 on 2021/6/23.
//

#import "MerchantCell.h"

@implementation MerchantCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    LXViewBorder(self.bgView, 5)
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
