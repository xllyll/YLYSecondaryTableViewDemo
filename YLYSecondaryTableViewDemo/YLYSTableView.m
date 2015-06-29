//
//  YLYSTableView.m
//  YLYSecondaryTableViewDemo
//
//  Created by 杨卢银 on 15/6/27.
//  Copyright (c) 2015年 杨卢银. All rights reserved.
//
#define KSectionTitleViewHight 40


#import "YLYSTableView.h"

@interface YLYSTableViewHeadView ()

@end

@implementation YLYSTableViewHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    self= [super initWithFrame:frame];
    if(self){
        
    }
    return self;
}

@end

@interface YLYSTableView ()
{
    NSMutableArray *_changeData;
    BOOL changeType;
    NSMutableArray *_sectionHeadViews;
    
}
@end

@implementation YLYSTableView


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setData:(NSArray *)data{
    changeType = NO;
    _data = data;
    _changeData= [[NSMutableArray alloc]init];
    //
    for (NSDictionary *dic  in _data) {
        NSMutableDictionary *info = [NSMutableDictionary dictionaryWithDictionary:dic];
        [info setObject:@[] forKey:@"list"];
        [_changeData addObject:info];
    }
}
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource=self;
        self.delegate =self;
        self.tableFooterView=[[UIView alloc]init];
        _sectionHeadViews = [NSMutableArray array];
    }
    return self;
}
-(void)awakeFromNib{
    self.dataSource = self;
    self.delegate = self;
    self.tableFooterView=[[UIView alloc]init];
    
    _sectionHeadViews = [NSMutableArray array];
}
-(void)closeChooseData{
    
}

#pragma tableView Datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
   
    if (_sDataSource) {
        return [_sDataSource numberOfSectionsInYLYSTableView:self];
    }
    
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (changeType) {
        return [_changeData[section][@"list"] count];
    }else{
        if (_sDataSource) {
            return [_sDataSource ylystableView:self numberOfRowsInSection:section];
        }
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_sDataSource) {
        return  [_sDataSource ylystableView:self cellForRowAtIndexPath:indexPath];
    }
    
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    YLYSTableViewHeadView *headView;
    for (YLYSTableViewHeadView *view in _sectionHeadViews) {
        if (view.tag==section) {
            headView=view;
        }
    }
    if (headView) {
        
    }else{
        headView = [[YLYSTableViewHeadView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, KSectionTitleViewHight)];
        headView.tag = section;
        headView.isopen=NO;
        headView.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0f];
        [headView addTarget:self action:@selector(sectionHeadViewCheck:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(20,0 , 100, KSectionTitleViewHight)];
        lable.text=@"";
        if (_sDataSource ) {
            lable.text= [_sDataSource ylystableView:self titleForHeaderInSection:section];
        }
        [headView addSubview:lable];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.bounds.size.width-(KSectionTitleViewHight-10.0*2)-20, 10, (KSectionTitleViewHight-10.0*2), (KSectionTitleViewHight-10.0*2))];
        imageView.image = [UIImage imageNamed:@"right_image"];
        [headView addSubview:imageView];
        headView.tag= section;
        [_sectionHeadViews addObject:headView];
    }
    
    
    return headView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return KSectionTitleViewHight;
}
#pragma headViewCheck
-(void)sectionHeadViewCheck:(YLYSTableViewHeadView*)sender{
    changeType=YES;
    NSInteger section = sender.tag;
    NSDictionary *info = _changeData[section];
    if (sender.isopen) {
        sender.isopen = NO;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:info];
        int rows = (int)[dic[@"list"] count];
        for (int i = 0 ; i < rows;i++) {
            NSMutableArray *array = [NSMutableArray arrayWithArray:dic[@"list"]];
            if (array.count>0) {
                [array removeObjectAtIndex:rows-i-1];
            }
            [dic setObject:array forKey:@"list"];
            [_changeData removeObjectAtIndex:section];
            [_changeData insertObject:dic atIndex:section];
            [self beginUpdates];
            [self deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:rows-i-1 inSection:section]] withRowAnimation:UITableViewRowAnimationBottom];
            [self endUpdates];
        }
        
        
    }else{
        sender.isopen=YES;
        NSArray *data_array = _data[section][@"list"];
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:info];
        int rows = (int)[_data[section][@"list"] count];
        for (int i = 0 ; i < rows;i++) {
            NSMutableArray *array = [NSMutableArray arrayWithArray:dic[@"list"]];
            [array addObject:data_array[i]];
            [dic setObject:array forKey:@"list"];
            [_changeData removeObjectAtIndex:section];
            [_changeData insertObject:dic atIndex:section];
            [self beginUpdates];
            [self insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:i inSection:section]] withRowAnimation:UITableViewRowAnimationTop];
            [self endUpdates];
        }
    }
}

@end
