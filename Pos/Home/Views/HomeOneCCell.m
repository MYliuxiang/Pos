//
//  HomeOneCCell.m
//  Pos
//
//  Created by 刘翔 on 2021/6/18.
//

#import "HomeOneCCell.h"

@implementation HomeOneCCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(ShopItemModel *)model
{
    _model = model;
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.indexImg]];
    self.nameL.text = model.name;
    self.priceL.text = [NSString stringWithFormat:@"￥%.f",model.price];
}

@end
