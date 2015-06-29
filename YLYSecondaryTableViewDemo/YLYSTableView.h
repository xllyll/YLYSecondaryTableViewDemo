//
//  YLYSTableView.h
//  YLYSecondaryTableViewDemo
//
//  Created by 杨卢银 on 15/6/27.
//  Copyright (c) 2015年 杨卢银. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YLYSTableView;

@protocol YLYSTableViewDatasource <NSObject>

-(NSInteger)numberOfSectionsInYLYSTableView:(YLYSTableView *)tableView;

-(NSInteger)ylystableView:(YLYSTableView *)stableView numberOfRowsInSection:(NSInteger)section;

-(UITableViewCell *)ylystableView:(YLYSTableView *)stableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
/**
 *返回分组名称
 */
-(NSString *)ylystableView:(YLYSTableView *)tableView titleForHeaderInSection:(NSInteger)section;

@end



@interface YLYSTableViewHeadView :UIControl

@property( nonatomic)BOOL isopen;

@end
/**
 *二级菜单TableView
 *
 */
@interface YLYSTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

@property (weak , nonatomic)id<YLYSTableViewDatasource>sDataSource;

@property (weak , nonatomic)NSArray *data;



@end
