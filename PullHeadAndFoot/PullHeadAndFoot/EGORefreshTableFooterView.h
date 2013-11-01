//
//  EGORefreshTableFooterView.h
//  ZJGOnline_Ipad
//
//  Created by 尚为 周泉 on 12-6-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum{
	EGOOPushRefreshPushing = 0,
	EGOOPushRefreshNormal,
	EGOOPushRefreshLoading,	
} EGOPushRefreshState;

@protocol EGORefreshTableFooterDelegate;
@interface EGORefreshTableFooterView : UIView {
	
	id _delegate;
	EGOPushRefreshState _state;
    
	UILabel *_lastUpdatedLabel;
	UILabel *_statusLabel;
	CALayer *_arrowImage;
	UIActivityIndicatorView *_activityView;
	
    
}

@property(nonatomic,assign) id <EGORefreshTableFooterDelegate> delegate;

- (void)refreshLastUpdatedDate;
- (void)egoRefreshScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)egoRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView;
- (void)egoRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView;

@end
@protocol EGORefreshTableFooterDelegate
- (void)egoRefreshTableFooterDidTriggerRefresh:(EGORefreshTableFooterView*)view;
- (BOOL)egoRefreshTableFooterDataSourceIsLoading:(EGORefreshTableFooterView*)view;
@optional
- (NSDate*)egoRefreshTableFooterDataSourceLastUpdated:(EGORefreshTableFooterView*)view;
@end
