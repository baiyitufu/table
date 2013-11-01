//
//  ViewController.h
//  PullHeadAndFoot
//
//  Created by Devil on 13-7-18.
//  Copyright (c) 2013年 com.shinyv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "EGORefreshTableFooterView.h"
@interface ViewController : UIViewController<UITableViewDataSource,
UITableViewDelegate,EGORefreshTableFooterDelegate,EGORefreshTableHeaderDelegate>{
    //下拉刷新
    BOOL _reloading;
    EGORefreshTableHeaderView *_refreshHeaderView;
    //上拉刷新
    BOOL _dragupLoading;
    EGORefreshTableFooterView * _refreshFooterView;
    BOOL _dragDirection;//Up - YES
    UITableView * tabView; 
}

@end
