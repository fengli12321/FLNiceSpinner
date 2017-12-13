# FLNiceSpinner

[![CI Status](http://img.shields.io/travis/fengli12321@163.com/FLNiceSpinner.svg?style=flat)](https://travis-ci.org/fengli12321@163.com/FLNiceSpinner)
[![Version](https://img.shields.io/cocoapods/v/FLNiceSpinner.svg?style=flat)](http://cocoapods.org/pods/FLNiceSpinner)
[![License](https://img.shields.io/cocoapods/l/FLNiceSpinner.svg?style=flat)](http://cocoapods.org/pods/FLNiceSpinner)
[![Platform](https://img.shields.io/cocoapods/p/FLNiceSpinner.svg?style=flat)](http://cocoapods.org/pods/FLNiceSpinner)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.


![2017-12-13 23.09.32.gif](https://github.com/fengli12321/FLNiceSpinner/blob/master/2017-12-13%2023.09.32.gif)


##### 1.同步数据
```objc
FLNiceSpinner *spinner = [[FLNiceSpinner alloc] initWithFrame:CGRectMake(50, 100, 100, 30)];
    spinner.delegate = self;
    [self.view addSubview:spinner];
```

###### 实现协议方法
```objc
- (NSString *)fl_spinner:(FLNiceSpinner *)spinner showItemStringAtIndex:(NSInteger)index {
    if ([spinner isEqual:_spinner1]) {
        return _arr1[index];
    }
    else if ([spinner isEqual:_spinner2]) {
        return _arr2[index];
    }
    else if ([spinner isEqual:_spinner3]) {
        return _arr3[index];
    }
    else if ([spinner isEqual:_spinner4]) {
        return _arr4[index];
    }
    else if ([spinner isEqual:_spinner5]) {
        return _arr5[index];
    }
    else if ([spinner isEqual:_spinner6]) {
        return _arr6[index];
    }
    else if ([spinner isEqual:_spinner7]) {
        return _arr7[index];
    }
    else if ([spinner isEqual:_spinner8]) {
        return _arr8[index];
    }
    else if ([spinner isEqual:_spinner9]) {
        return _arr9[index];
    }
    return nil;
}
- (NSInteger)fl_itemsCountOfSpinner:(FLNiceSpinner *)spinner {
    if ([spinner isEqual:_spinner1]) {
        
        return _arr1.count;
    }
    else if ([spinner isEqual:_spinner2]) {
        return _arr2.count;
    }
    else if ([spinner isEqual:_spinner3]) {
        return _arr3.count;
    }
    else if ([spinner isEqual:_spinner4]) {
        return _arr4.count;
    }
    else if ([spinner isEqual:_spinner5]) {
        return _arr5.count;
    }
    else if ([spinner isEqual:_spinner6]) {
        return _arr6.count;
    }
    else if ([spinner isEqual:_spinner7]) {
        return _arr7.count;
    }
    else if ([spinner isEqual:_spinner8]) {
        return _arr8.count;
    }
    else if ([spinner isEqual:_spinner9]) {
        return _arr9.count;
    }
    return 0;
}
```

##### 2.异步方法
###### 用于异步数据加载，例如数据需要通过网络加载
```objc
FLNiceSpinner *spinner = [[FLNiceSpinner alloc] initWithFrame:CGRectMake(50, 100, 100, 30)];
spinner.delegate = self;
spinner.isAsyncGetData = YES
[self.view addSubview:spinner];
```
###### 实现代理方法
```objc
- (void)fl_spinner:(FLNiceSpinner *)spinner requestDataSuccess:(void (^)(NSArray<NSString *> *))success fail:(void (^)(void))fail {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        success(@[@"中文", @"英文", @"法语", @"德语", @"西班牙语", @"四川话"]);
    });
}
```

| 属性       		   | 名称           | 值  |
| ------------- 	|:-------------:| -----:|
|   占位提示文字   | spaceString | NSString |
| 文本框文字颜色     | textColor      |   UIColor |
| 文本框背景颜色 | backColor     |    UIColor |
|文本框选中后背景颜色|selectedBackColor|UIColor|
|文本框字体大小|font|UIFont|
|清空项提示字符|clearNoteString|NSString|
|列表项文字大小|listItemFont|UIFont|
|列表项高度|listItemHeight|CGFlot|
|列表文字颜色|listItemTextColor|UIColor|
|弹出时最大显示行数|maxShowLines|NSUInteger|
|弹出框的背景颜色|spinnerBackColor|UIColor|
|按钮圆角|cornerRadius|CGFloat|
|展开收起提示用图标|noteImage|NSString|
|选中项的下标|selectedIndex|NSInteager|
|是否是异步的方式获取数据|isAsyncGetData|BOOL|


## Requirements

iOS8.0+

## Installation

FLNiceSpinner is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'FLNiceSpinner'
```

## Author

fengli12321@163.com, 954751186@qq.com

## License

FLNiceSpinner is available under the MIT license. See the LICENSE file for more info.
