//
//  BusinessCell.m
//  Pos
//
//  Created by tenvine on 2021/6/22.
//

#import "BusinessCell.h"

@implementation BusinessCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    LXViewBorder(self.bgView, 10);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
