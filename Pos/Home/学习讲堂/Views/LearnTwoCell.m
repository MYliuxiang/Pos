//
//  LearnTwoCell.m
//  Pos
//
//  Created by 刘翔 on 2021/6/23.
//

#import "LearnTwoCell.h"

@implementation LearnTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(StudyListModel *)model{
    _model = model;
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.indexUrl]];
    self.titleL.text = model.title;
    self.timeL.text = model.createTime;
}

@end
