//
//  HomeTwoCCell.m
//  Pos
//
//  Created by 刘翔 on 2021/6/18.
//

#import "HomeTwoCCell.h"

@implementation HomeTwoCCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.img.layer.cornerRadius = 10;
    self.img.layer.masksToBounds = YES;
}

@end
