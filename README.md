# UtilCore

UtilCore 之前每次新建项目的时候，有很多基础工具库和一些基本的项目依赖每次都得添加，感觉这些东西有很多公用的地方，然后UtilCore就慢慢积累起来了，基本上包含了一些简单基础工具库

## 使用要求

* Xcode 9.0+
## 安装

### CocoaPods

```ruby
pod 'UtilCore', '~> 0.0.1'
```

## 包含的功能有

### 1. loading的支持

  这块可以支持[NVActivityIndicatorView](https://github.com/ninjaprox/NVActivityIndicatorView)的所有动画,并且支持自定义加载动画

  ![](https://raw.githubusercontent.com/ninjaprox/NVActivityIndicatorView/master/Demo.gif)
![](./doc/loading.png)
#### 具体使用

在`AppDelegate`的`didFinishLaunchingWithOptions`方法中配置

##### NVActivityIndicatorView动画类型
```swift
    // 可以设置`NVActivityIndicatorView`中支持的所有类型
    UtilCore.loadingView  = .activityIndicatorType(type: .ballBeat)
    // 设置动画的颜色
    UtilCore.loadingBgColor = .purple
```
#### 自定义加载动画
```swift
    // example项目中有自定义view
    let loading = CircleLogoView(28)
    // 每秒转的圈数
    loading.circleByOneSecond = 3.0
    //设置自定义加载动画
    UtilCore.loadingView  = .customView(loadingView: loading)
    UtilCore.loadingBgColor = .white
```
### 网络错误界面

#### 预览
![](./doc/errorpage.png)

#### 具体代码
```swift
self.test_Btn
    .rx.tap
    .map{MikerError("testdomain",code:10010,message:"测试错误信息啊")}
    .bind(to: self.rx_showerrorpage)
    .disposed(by: self.disposeBag)
```
 这块具体说下，这块主要配合[NetWorkCore](https://github.com/SeongBrave/NetWorkCore)可以在发生网络错误的时候，就可以直接显示到界面上，并且可以点击重新加载又会触发`MVVM`中`ViewModel`中的重新加载信号
 ```swift
   self.manageVm?
            .refresherror
            .asObserver()
            .bindTo(self.rx_showerrorpage)
            .disposed(by: disposeBag)
    self.errorPageView
         .reloadSubject
         .bindTo(self.manageVm!.reloadTrigger)
         .disposed(by: disposeBag)
 ```
