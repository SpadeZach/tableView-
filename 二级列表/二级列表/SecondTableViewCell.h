//
//  SecondTableViewCell.h
//  二级列表
//
//  Created by 赵博 on 16/10/13.
//  Copyright © 2016年 赵博. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondTableViewCell : UITableViewCell
@property (nonatomic,retain) UILabel * Name;
@property (nonatomic,retain) UILabel * Comments;
@property (nonatomic,strong) NSArray *ChildArray;//存放子菜单
@property (nonatomic,assign) BOOL  Open;//表示子菜单是否打开
@end
