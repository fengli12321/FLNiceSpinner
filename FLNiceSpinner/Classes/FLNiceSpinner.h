//
//  FLNiceSpinner.h
//  FLNiceSpinner
//
//  Created by 冯里 on 2017/12/12.
//  Copyright © 2017年 冯里. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FLNiceSpinnerDelegate;

@interface FLNiceSpinner : UIButton

@property (nonatomic, weak) NSObject <FLNiceSpinnerDelegate> *delegate;

/**
 当未选择时的的占位提示文字, 默认提示“请选择”
 */
@property (nonatomic, copy) NSString *spaceString;


/**
 文本框文字颜色（默认blackColor）
 */
@property (nonatomic, strong) UIColor *textColor;


/**
 文本框背景颜色（默认clearColor）
 */
@property (nonatomic, strong) UIColor *backColor;


/**
 文本框选中后背景颜色(默认 rgb(220, 220, 220))
 */
@property (nonatomic, strong) UIColor *selectedBackColor;


/**
 文本框字体大小 （默认14）
 */
@property (nonatomic, strong) UIFont *font;


/**
 清空项提示字符(默认：“清空选择”)
 */
@property (nonatomic, strong) NSString *clearNoteString;

/**
 列表项文字大小，默认14pt
 */
@property (nonatomic, strong) UIFont *listItemFont;


/**
 列表项高度,默认35
 */
@property (nonatomic, assign) CGFloat listItemHeight;


/**
 列表文字颜色，默认黑色
 */
@property (nonatomic, strong) UIColor *listItemTextColor;


/**
 弹出时最大显示行数，默认5
 */
@property (nonatomic, assign) NSUInteger maxShowLines;


/**
 弹出框的背景颜色，默认为whiteColor
 */
@property (nonatomic, strong) UIColor *spinnerBackColor;


/**
 按钮圆角，默认为3
 */
@property (nonatomic, assign) CGFloat cornerRadius;


/**
 展开收起提示用图标
 */
@property (nonatomic, copy) NSString *noteImage;

/**
 选中项的下标，-1时表示未选择
 */
@property (nonatomic, assign) NSInteger selectedIndex;


/**
 是否是异步的方式获取数据,默认为NO，同步方式获取数据（fl_spinner:showItemStringAtIndex）
 */
@property (nonatomic, assign) BOOL isAsyncGetData;



@end

@protocol FLNiceSpinnerDelegate


@optional


/**
 fl_spinner:requestDataSuccess:fail: 方法 和 fl_spinner:showItemStringAtIndex 方法二者选其一
 前者用于异步数据的返回，例如下拉数据需要通过网络进行异步请求
 后者和fl_itemsCountOfSpinner:组合使用，用于立即可以得到的数据
 
 默认通过 fl_spinner:showItemStringAtIndex 方法同步获取数据源
 通过属性 isAsyncGetData 进行设置
 */


/**
 数据源，用于异步请求数据

 @param spinner 下拉视图
 @param success 返回需要展示的数据，数组中存放下拉展示字符串
 @param fail 数据请求失败
 */
- (void)fl_spinner:(FLNiceSpinner *)spinner requestDataSuccess:(void(^)(NSArray <NSString*>* listShowStrings))success fail:(void(^)(void))fail;

/**
 下拉菜单数据总数
 
 @param spinner 下拉视图
 @return 数量
 */
- (NSInteger)fl_itemsCountOfSpinner:(FLNiceSpinner *)spinner;


/**
 某行展示字符
 
 @param spinner 下拉视图
 @param index 行数
 @return 展示字符
 */
- (NSString *)fl_spinner:(FLNiceSpinner *)spinner showItemStringAtIndex:(NSInteger)index;


/**
 选中了某行数据（-1表示数据清空）

 @param spinner 下拉视图
 @param index 选中行
 */
- (void)fl_spinner:(FLNiceSpinner *)spinner didSelectedItemAtIndex:(NSInteger)index;

@end
