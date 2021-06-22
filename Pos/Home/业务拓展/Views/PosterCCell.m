//
//  PosterCCell.m
//  Pos
//
//  Created by tenvine on 2021/6/22.
//

#import "PosterCCell.h"

@implementation PosterCCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.cornerRadius=10;
    self.layer.shadowColor=[UIColor blackColor].CGColor;
    self.layer.shadowOffset=CGSizeMake(5, 5);
    self.layer.shadowOpacity=0.3;
    self.layer.shadowRadius=5;
    
}

@end
