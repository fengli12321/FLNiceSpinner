//
//  FLNiceSpinner.m
//  FLNiceSpinner
//
//  Created by 冯里 on 2017/12/12.
//  Copyright © 2017年 冯里. All rights reserved.
//

#import "FLNiceSpinner.h"

@interface FLNiceSpinner() <UITableViewDelegate, UITableViewDataSource>

// 展开收起提示图片
@property (nonatomic, strong) UIImageView *unfoldImage;
// 展示列表
@property (nonatomic, strong) UITableView *table;
// 阴影
@property (nonatomic, strong) CALayer *shadowLayer;
// 遮罩视图
@property (nonatomic, strong) UIView *coverView;

// 数据源
@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;   // 菊花转


@end

@implementation FLNiceSpinner
#pragma mark - Lazy
- (UITableView *)table {
    
    if (!_table) {
        _table = [[UITableView alloc] init];
        _table.delegate = self;
        _table.dataSource = self;
        _table.rowHeight = self.listItemHeight;
        [_table setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _table.layer.borderWidth = 0.5;
        _table.layer.borderColor = [UIColor colorWithRed:183/255.0 green:183/255.0 blue:183/255.0 alpha:1].CGColor;
        _table.layer.cornerRadius = 5;
        _table.bounces = YES;
        
        // 添加阴影
        self.shadowLayer = [[CALayer alloc] init];
        self.shadowLayer.bounds = _table.bounds;
        self.shadowLayer.backgroundColor = [UIColor whiteColor].CGColor;
        self.shadowLayer.cornerRadius = 5;
        // 设置阴影
        self.shadowLayer.shadowColor = [UIColor grayColor].CGColor;
        self.shadowLayer.shadowOffset = CGSizeMake(2, 2);
        self.shadowLayer.shadowOpacity = 0.9;
    }
    return _table;
}
- (UIView *)coverView {
    if (!_coverView) {
        _coverView = [[UIView alloc] initWithFrame:[self getWindow].bounds];
        _coverView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showTable)];
        [_coverView addGestureRecognizer:tap];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        
        [_coverView addGestureRecognizer:pan];
    }
    return _coverView;
}
#pragma mark - LifeCycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initialize];
        [self creatUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        
        [self initialize];
        [self creatUI];
    }
    return self;
}

/**
 数据初始化
 */
- (void)initialize {
    self.spaceString = @"请选择";
    self.selectedIndex = -1;
    self.textColor = [UIColor blackColor];
    self.backColor = [UIColor clearColor];
    self.font = [UIFont systemFontOfSize:14];
    _selectedBackColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
    _clearNoteString = @"清空选择";
    _listItemFont = [UIFont systemFontOfSize:14];
    _listItemHeight = 35.0f;
    _listItemTextColor = [UIColor blackColor];
    _maxShowLines = 5;
    _spinnerBackColor = [UIColor whiteColor];
    self.cornerRadius = 3;
    
    self.isAsyncGetData = NO;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.unfoldImage.frame = CGRectMake(self.frame.size.width - 10 - 12, self.frame.size.height/2.0 - 12/2.0, 12, 12);
    
    CGRect frame = self.indicatorView.frame;
    frame.origin.y = (self.frame.size.height - frame.size.height)/2.0;
    frame.origin.x = CGRectGetMinX(self.unfoldImage.frame) - frame.size.width - 10;
    self.indicatorView.frame = frame;
}
#pragma mark - UI
- (void)creatUI {
    
    [self addTarget:self action:@selector(showTable) forControlEvents:UIControlEventTouchUpInside];
    [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    
    self.unfoldImage = [[UIImageView alloc] init];
    self.unfoldImage.image = [self imageNamedFromMyBundle:@"fl_spinner_icon"];;
    [self.unfoldImage setContentMode:UIViewContentModeScaleAspectFit];
    [self addSubview:self.unfoldImage];
    
    // 菊花转
    self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self addSubview:self.indicatorView];
}

- (UIImage *)imageNamedFromMyBundle:(NSString *)name {
    NSBundle *imageBundle = [self tz_imagePickerBundle];
    name = [name stringByAppendingString:@"@2x"];
    NSString *imagePath = [imageBundle pathForResource:name ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    if (!image) {
        // 兼容业务方自己设置图片的方式
        name = [name stringByReplacingOccurrencesOfString:@"@2x" withString:@""];
        image = [UIImage imageNamed:name];
    }
    return image;
}

- (NSBundle *)tz_imagePickerBundle {
    NSBundle *bundle = [NSBundle bundleForClass:[FLNiceSpinner class]];
    NSURL *url = [bundle URLForResource:@"FLNiceSpinner" withExtension:@"bundle"];
    bundle = [NSBundle bundleWithURL:url];
    return bundle;
}
#pragma mark - private

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    self.backgroundColor = selected?_selectedBackColor:_backColor;
}


- (void)showTable {
    
    if (self.selected) {
        [self hide];
    }
    else {
        
        if (self.isAsyncGetData) {
            
            NSAssert(self.delegate && [self.delegate respondsToSelector:@selector(fl_spinner:requestDataSuccess:fail:)], @"未实现协议方法fl_spinner:requestDataSuccess:fail:");
            
            __weak typeof(self) weakSelf = self;
            [self.indicatorView startAnimating];
            [self.delegate fl_spinner:self requestDataSuccess:^(NSArray<NSString *> *listShowStrings) {
                
                weakSelf.dataArray = listShowStrings;
                [weakSelf.indicatorView stopAnimating];
                [weakSelf show];
                
            } fail:^{
                [weakSelf.indicatorView stopAnimating];
                weakSelf.selected = !weakSelf.selected;
            }];
            
        }
        else {
            [self show];
        }
        
    }
    
    self.selected = !self.selected;
}

/**
 展示列表
 */
- (void)show {
    
    
    
    [self.table reloadData];
    
    NSInteger count = 0;
    if (self.delegate && [self.delegate respondsToSelector:@selector(fl_itemsCountOfSpinner:)]) {
        count = [self.delegate fl_itemsCountOfSpinner:self] + 1;
    }
    
    NSInteger padding = 5;
    CGFloat tableHeight = count > _maxShowLines ? _listItemHeight * _maxShowLines : _listItemHeight * count - 5;
    CGRect selfFrame = [self convertRect:self.bounds toView:[self getWindow]];
    
    UIScrollView *superScrollView = [self findSuperScrollViewWithView:self];
    
    CGFloat rotation = M_PI/2.0;
    if (superScrollView) {
        
        CGRect selfFrameInScrollView = [self convertRect:self.bounds toView:superScrollView];
        
        CGFloat insertV = CGRectGetMaxY(selfFrameInScrollView) + padding + tableHeight - superScrollView.frame.size.height - superScrollView.contentOffset.y;
        if (insertV > 0) {
            
            if (superScrollView.contentOffset.y + superScrollView.frame.size.height + insertV < superScrollView.contentSize.height) {
                
                CGPoint offset = superScrollView.contentOffset;
                offset.y += insertV;
                [superScrollView setContentOffset:offset];
                _table.frame = CGRectMake(selfFrame.origin.x, CGRectGetMaxY(selfFrame) + 5 - insertV, selfFrame.size.width, tableHeight);
            }
            else {
                rotation = -rotation;
                _table.frame = CGRectMake(selfFrame.origin.x, selfFrame.origin.y - padding - tableHeight, selfFrame.size.width, tableHeight);
            }
        }
        else {
            _table.frame = CGRectMake(selfFrame.origin.x, CGRectGetMaxY(selfFrame) + 5, selfFrame.size.width, tableHeight);
        }
    }
    else {
        
        CGRect selfFrameInScrollView = [self convertRect:self.bounds toView:[self getWindow]];
        
        CGFloat insertV = CGRectGetMaxY(selfFrameInScrollView) + padding + tableHeight - [self getWindow].frame.size.height;
        if (insertV > 0) {
            rotation = -rotation;
            _table.frame = CGRectMake(selfFrame.origin.x, selfFrame.origin.y - padding - tableHeight, selfFrame.size.width, tableHeight);
        }
        else {
            
            _table.frame = CGRectMake(selfFrame.origin.x, CGRectGetMaxY(selfFrame) + 5, selfFrame.size.width, tableHeight);
        }
    }
    
    

    
    // 阴影
    //设置中心点
    self.shadowLayer.position = CGPointMake(_table.frame.origin.x + _table.frame.size.width/2, _table.frame.origin.y + _table.frame.size.height/2);
    //设置大小
    self.shadowLayer.bounds = _table.bounds;
    
    
    [UIView animateWithDuration:0.15 animations:^{
        
        
        [self.unfoldImage setTransform:CGAffineTransformRotate(CGAffineTransformIdentity, rotation)];
    } completion:^(BOOL finished) {
        
        [[self getWindow] addSubview:self.coverView];
        [[self getWindow].layer addSublayer:self.shadowLayer];
        [[self getWindow] addSubview:self.table];
    }];
}


/**
 收起列表
 */
- (void)hide {
    
    [self.coverView removeFromSuperview];
    [self.shadowLayer removeFromSuperlayer];
    [self.table removeFromSuperview];
    [UIView animateWithDuration:0.3 animations:^{
        
        [self.unfoldImage setTransform:CGAffineTransformIdentity];
    }];
}

- (UIWindow *)getWindow {
    return [UIApplication sharedApplication].delegate.window;
}

#pragma mark - Set
- (void)setFont:(UIFont *)font {
    _font = font;
    self.titleLabel.font = font;
}
- (void)setSpaceString:(NSString *)spaceString {
    _spaceString = [spaceString copy];
    [self setTitle:spaceString forState:UIControlStateNormal];
}
- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
}
- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    if (selectedIndex == -1) {
        [self setTitle:self.spaceString forState:UIControlStateNormal];
    }
    else {
        if (self.isAsyncGetData) {
            [self setTitle:self.dataArray[selectedIndex] forState:UIControlStateNormal];
        }
        else {
            NSString *string;
            if (self.delegate && [self.delegate respondsToSelector:@selector(fl_spinner:showItemStringAtIndex:)]) {
                string = [self.delegate fl_spinner:self showItemStringAtIndex:selectedIndex];
            }
            [self setTitle:string forState:UIControlStateNormal];
        }
        
    }
}

// 找寻上层滚动视图
- (UIScrollView *)findSuperScrollViewWithView:(UIView *)view {
    if ([view isEqual:[self getWindow]]) {  // 找到顶层，没有找到
        return nil;
    }
    else if ([view.superview isKindOfClass:[UIScrollView class]]) {
        
        if ([view.superview.superview isKindOfClass:[UITableView class]]) { // 如果是tableview，往上找
            UITableView *tableView = (UITableView *)view.superview.superview;
            
            UIScrollView *scrollView = [self findSuperScrollViewWithView:tableView];
            if (scrollView) {   // tableView往上找到，返回
                
                return scrollView;
            }
            else {  // tableview往上没有找到，返回tableview
                return tableView;
            }
            
        }
        else if ([view.superview isKindOfClass:[UITableView class]]) {
            UITableView *tableView = (UITableView *)view.superview;
            
            UIScrollView *scrollView = [self findSuperScrollViewWithView:tableView];
            if (scrollView) {   // tableView往上找到，返回
                
                return scrollView;
            }
            else {  // tableview往上没有找到，返回tableview
                return tableView;
            }
        }
        else {
            UIScrollView *scrollView = (UIScrollView *)view.superview;
            if (scrollView.contentSize.height > scrollView.frame.size.height) { // 如果是纵向滚动的tableView， 返回
                return scrollView;
            }
            else {
                return nil;
            }
        }
    }
    else { // 没有找到往上继续
        return [self findSuperScrollViewWithView:view.superview];
    }
}

- (void)setNoteImage:(NSString *)noteImage {
    _noteImage = noteImage;
    UIImage *image = [UIImage imageNamed:noteImage];
    if (image != nil) {
        self.unfoldImage.image = [UIImage imageNamed:noteImage];
    }
    
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    [self setTitleColor:textColor forState:UIControlStateNormal];
}

- (void)setBackColor:(UIColor *)backColor {
    _backColor = backColor;
    self.backgroundColor = backColor;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.isAsyncGetData) {
        return self.dataArray.count + 1;
    }
    else {
        if (self.delegate && [self.delegate respondsToSelector:@selector(fl_itemsCountOfSpinner:)]) {
            return [self.delegate fl_itemsCountOfSpinner:self] + 1;
        }
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    CGRect frame = cell.frame;
    frame.origin.x -= 15;
    cell.textLabel.frame = frame;
    NSString *str = @"代理方法未实现";
    
    if (indexPath.row == 0) {
        str = self.clearNoteString;
    }
    else {
        if (self.isAsyncGetData) {
            str = self.dataArray[indexPath.row - 1];
        }
        else {
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(fl_spinner:showItemStringAtIndex:)]) {
                str = [self.delegate fl_spinner:self showItemStringAtIndex:indexPath.row - 1];
            }
        }
    }
    
    cell.textLabel.text = str;
    cell.textLabel.font = self.listItemFont;
    cell.textLabel.textColor = self.listItemTextColor;
    cell.backgroundColor = self.spinnerBackColor;
    
    return cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.selectedIndex = indexPath.row - 1;
    if (self.delegate && [self.delegate respondsToSelector:@selector(fl_spinner:didSelectedItemAtIndex:)]) {
        [self.delegate fl_spinner:self didSelectedItemAtIndex:indexPath.row - 1];
    }
    [self showTable];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    cell.layer.anchorPoint = CGPointMake(0, 0.5);
    //为了防止cell视图移动，重新把cell放回原来的位置
    cell.layer.position = CGPointMake(0, cell.layer.position.y);
    [cell.layer setTransform:CATransform3DTranslate(CATransform3DIdentity, 0, -15, 0)];
    cell.alpha = 0.2;
    [UIView animateWithDuration:0.5 animations:^{
        cell.layer.transform = CATransform3DIdentity;
        cell.alpha = 1.0;
    }];
}

@end
