//
//  TableViewCell.m
//  二级列表
//
//  Created by 赵博 on 16/10/13.
//  Copyright © 2016年 赵博. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell
-(instancetype)init{
    if(self = [super init]){
        _Name = [[UILabel alloc] init];
        _Name.frame= CGRectMake(0, 0, 50, 30);
        [self.contentView addSubview:_Name];//将控件插入uitablviewecell
        _Comments = [[UILabel alloc]init];
        _Comments.frame = CGRectMake(60, 0, 50, 30);
        [self.contentView addSubview:_Comments];//将控件插入uitablviewecell
        _Open=false;//默认子控件是关闭的
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
