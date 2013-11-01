//
//  ViewController.m
//  PullHeadAndFoot
//
//  Created by Devil on 13-7-18.
//  Copyright (c) 2013年 com.shinyv. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    tabView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 460)];
    tabView.delegate=self;
    tabView.dataSource=self;
    [self.view addSubview:tabView];
    
    /*下拉刷新*/
    if (_refreshHeaderView == nil) {
        
        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc]
                                           initWithFrame:CGRectMake(0.0f, 0.0f - tabView.bounds.size.height, self.view.frame.size.width, tabView.bounds.size.height)];
        view.delegate = self;
        [tabView addSubview:view];
        _refreshHeaderView = view ;
        [view release];
        
    }
    [_refreshHeaderView refreshLastUpdatedDate];
    
    /*上拉刷新*/
    if (_refreshFooterView==nil) {
        
        _refreshFooterView=[[EGORefreshTableFooterView alloc] initWithFrame:
                            CGRectMake(0, tabView.frame.size.height, self.view.frame.size.width, tabView.bounds.size.height)];
        _refreshFooterView.delegate=self;
        [tabView addSubview:_refreshFooterView];
        [_refreshFooterView refreshLastUpdatedDate];
    }
	// Do any additional setup after loading the view, typically from a nib.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 10;
}


- (void)reloadTableViewDataSource{
    if (_dragDirection) {
        _dragupLoading = YES;
        
    }else {
        _reloading= YES;
    }
    
}

//请求完数据调用这个方法 让转动消失

- (void)doneLoadingTableViewData{
    
    
    if (_dragDirection) {
        _dragupLoading = NO;
        [_refreshFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:tabView];
    }else {
        _reloading = NO;
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:tabView];
    }
    
    NSLog(@"disappear");
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset = scrollView.contentOffset.y;
    //下拉是负值，上拉是正值
    if (offset>0) {//上拉
        _dragDirection = YES;
 
        [_refreshFooterView egoRefreshScrollViewDidScroll:scrollView];
    } else if(offset <0){//下拉
        _dragDirection = NO;
       
        [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    }else {
        return;
    }
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (_dragDirection) {
        [_refreshFooterView egoRefreshScrollViewDidEndDragging:scrollView];
    }else {
        [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
        
    }
    
}


/*
 
 header
 
 
 */
#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    
//    NewData *newData = [NewData new];
//    [newData requestIndexData:self.columnID];
//    [newData requestProgramData:self.columnID];
//    [newData release];
    [ self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3];

    
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    
    return _reloading; // should return if data source model is reloading
    
}



/*
 
 foote 
 
 
 */

- (void)egoRefreshTableFooterDidTriggerRefresh:(EGORefreshTableFooterView*)view{
    
//    videoContent *content = [[self.contentDic objectForKey:self.columnID] objectAtIndex:0];
//    //    NSLog(@"content = %d",content.page);
//    MoreData *moreData = [[MoreData alloc] init];
//    [moreData requestProgramData:self.columnID andPage:content.page+1];
//	[moreData release];
    [ self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3];
  
}

- (BOOL)egoRefreshTableFooterDataSourceIsLoading:(EGORefreshTableFooterView*)view{
	
	return _dragupLoading; // should return if data source model is reloading
	
}
- (NSDate*)egoRefreshTableFooterDataSourceLastUpdated:(EGORefreshTableFooterView*)view{
    
    return [NSDate date];
}
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
       return [NSDate date];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell * cell =nil;
    cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"]autorelease];
    }
    cell.textLabel.text=@"sdfsdf";
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
