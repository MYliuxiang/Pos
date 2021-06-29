//
//  MailListCell.m
//  Pos
//
//  Created by 刘翔 on 2021/6/27.
//

#import "MailListCell.h"

@implementation MailListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(ContactsModel *)model
{
    _model = model;
    self.nameL.text = model.name;
    self.timeL.text = [NSString stringWithFormat:@"注册时间：%@",model.registerTime];
    self.phoneL.text = model.phone;
    self.userNumL.text = [NSString stringWithFormat:@"用户数：%ld",model.userNum];
}

@end
