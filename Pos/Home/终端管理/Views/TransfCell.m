//
//  TransfCell.m
//  Pos
//
//  Created by tenvine on 2021/6/21.
//

#import "TransfCell.h"

@implementation TransfCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        self.img.image = [UIImage imageNamed:@"组 25-1"];
    }else{
        self.img.image = [UIImage imageNamed:@"矩形 216"];
    }

}

@end
