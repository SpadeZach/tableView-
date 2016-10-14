//
//  ViewController.m
//  二级列表
//
//  Created by 赵博 on 16/10/13.
//  Copyright © 2016年 赵博. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"
#import <AFNetworking.h>
#import <JSONKit.h>
#import "SecondTableViewCell.h"
#import "BigModel.h"
@interface ViewController ()
@property (nonatomic,strong) NSMutableArray * TableArry;//要添加的进uitableview的数组，里面存放的是tablecell
@property (nonatomic,strong) NSMutableArray * InsertArry;//中间处理过程数组，用于插入子视图
@property (nonatomic,strong) NSMutableArray * DeleteArry;//中间处理过程数组，用于删除子视图
-(NSArray *) insertOperation:(TableViewCell *)item;//插入视图处理函数
-(NSArray *) deleteOperation:(TableViewCell *) item;//删除视图处理函数

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"二级列表";
    self.navigationItem.rightBarButtonItem =self.editButtonItem;
    self.tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    self.tableView.rowHeight = 70;
    
    _TableArry = [[NSMutableArray alloc]init];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [NSSet setWithObject:@"text/html"];
    NSDictionary *parameters = @{@"请求参数":@""};
    
    
    [manager POST:@"接口" parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        for (NSDictionary *dic in responseObject[@"item"]) {
            BigModel *recieveData = [[BigModel alloc] initWithDictionary:dic];
            SecondTableViewCell *cell0 = [[SecondTableViewCell alloc]init];
            cell0.Name.text = @"子菜单";
            cell0.Comments.text = @"子菜单";
            cell0.ChildArray=nil;
            NSMutableArray *array = [[NSMutableArray alloc] init];
            [array addObject:cell0];

            TableViewCell *cell = [[TableViewCell alloc]init];
            cell.Name.text=recieveData.SO_ID;
            cell.Comments.text = @"一级子菜单";
            cell.ChildArray = array;
            [_TableArry addObject:cell];
        }
        [self.tableView reloadData];
    
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    _InsertArry = [[NSMutableArray alloc]init];
    _DeleteArry = [[NSMutableArray alloc]init];
}
//返回tableview中cell的个数
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _TableArry.count;
}
//设置 cell的样式
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[TableViewCell alloc]init];
    if(indexPath.row<_TableArry.count)
    {
        cell = [_TableArry objectAtIndex:indexPath.row ];
    }
    
    return  cell;
}

//当cell被选择（被点击）时调用的函数
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TableViewCell *cell=[_TableArry objectAtIndex:indexPath.row];
    NSLog(@"%ld",indexPath.row);
  
    if(cell.ChildArray.count==0)//如果没有子菜单
    {
        NSLog(@"要打开页面");
    }else{
        if (!cell.Open) {
            cell.Name.text = @"1";
        }else{
            cell.Name.text=@"一级子菜单";
        }
        if(!cell.Open)//如果子菜单是关闭的
        {
            NSArray * array =  [self insertOperation:cell];
            if(array.count>0)
                //从视图中添加
                [self.tableView insertRowsAtIndexPaths: array withRowAnimation:UITableViewRowAnimationBottom ];
            
        }
        else//如果子菜单是打开的
        {
            NSArray * array = [self deleteOperation:cell];
            if(array.count>0)
                //从视图中删除
                [self.tableView deleteRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationBottom];
        }
    }
}
#pragma mark - 插入
-(NSArray *)insertOperation:(TableViewCell *)item
{
    [_InsertArry removeAllObjects];//将插入菜单清空
    NSIndexPath *path = [NSIndexPath indexPathForRow:[_TableArry indexOfObject:item] inSection:0];//获取选取的cell的位置
    NSLog(@"长度为%ld",path.row);
    TableViewCell  *child = [[TableViewCell alloc]init];
    //遍历当前选取cell 的子菜单
    for(int i=0;i<item.ChildArray.count;i++){
        child = [item.ChildArray objectAtIndex:i];
        [_TableArry insertObject:child atIndex:path.row + i +1 ];//调用数组函数将其插入其中
        [_InsertArry addObject:child];//放入插入数组中
    }
    item.Open=YES;//设置菜单已经打开
    NSMutableArray *PathArray= [NSMutableArray array];//初始化用于存放位置的数组
    for(TableViewCell * cell in _InsertArry)          {
        NSIndexPath *path = [NSIndexPath indexPathForRow:[_TableArry indexOfObject:cell] inSection:0];
        [PathArray addObject:path];
    }
    return PathArray;
}
-(NSArray *) deleteOperation:(TableViewCell *)item{
    [_DeleteArry removeAllObjects];//清空删除数组
    TableViewCell *child =[[TableViewCell alloc]init];//子菜单
    for(int i =0;i<item.ChildArray.count;i++)
    {
        child = [item.ChildArray objectAtIndex:i];
        [_DeleteArry addObject:child];//添加到删除数组
    }
    item.Open = NO;//设置子视图关闭
    NSMutableArray *mutableArry = [NSMutableArray array];
    NSMutableIndexSet *set= [NSMutableIndexSet indexSet];//设置用来存放删除的cell的索引
    for(TableViewCell *cell in _DeleteArry)
    {
        NSIndexPath *path = [NSIndexPath indexPathForRow:[_TableArry indexOfObject:cell] inSection:0];
        NSLog(@"%ld",path.row);
        [mutableArry addObject:path];
        [set addIndex:path.row];
    }
    [_TableArry removeObjectsAtIndexes:set];//调用函数来从数组中删除
    return mutableArry;
}
#pragma mark - 编辑模式
-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    //必须先调用父类方法
    [super setEditing:editing animated:animated];
    if (editing) {
        self.navigationItem.rightBarButtonItem.title = @"完成";
        
        [self.tableView setEditing:YES animated:YES];
        
        
    }else{
        
        self.navigationItem.rightBarButtonItem.title = @"编辑";
        
        //从视图中删除
        
        [self.tableView setEditing:NO animated:NO];
        
    }
    
}
#pragma mark - 编辑状态
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
    
}
#pragma mark - 按钮类型
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
    
}



@end
