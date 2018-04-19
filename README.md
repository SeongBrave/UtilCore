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

### 弹出框Toast

```swift
        self.test_Btn
            .rx.tap
            .subscribe(onNext: { [unowned self] ( _ ) in
                self.view.toast("简单弹出框")
            })
            .disposed(by: disposeBag)

```
通过给UIView 扩展`rx_error`属性，直接就可以把网络错误信号绑定到UIView的`rx_error`
```swift
extension UIView{
    /// 绑定rx 可以通过信号显示错误信息
   public var rx_error: AnyObserver<MikerError> {
    return Binder(self) { view, error in
            view.toastError(error)
            }.asObserver()
    }
}
```
具体使用时
```swift
self.manageVm?
            .error
            .asObserver()
            .bindTo(self.view.rx_error)
            .disposed(by: disposeBag)
```

### 对[URLNavigator](https://github.com/devxoul/URLNavigator)做了一些简单的扩展，使用起来非常方便
>URLNavigator帮助实现了项目的模块化

#### 统一封装生成路由链接
```swift
extension String {
    /// 返回路由路径
    ///
    /// - Parameter param: 请求参数
    public func  getUrlStr(param:[String:String]? = nil) -> String {
        let that = self.removingPercentEncoding ?? self
        let appScheme = Navigator.scheme
        let relUrl = "\(appScheme)://\(that)"
        guard param != nil else {
            return relUrl
        }
        var paramArr:[String] = []
        for (key , value) in param!{
            paramArr.append("\(key)=\(value)")
        }
        let rel = paramArr.joined(separator: "&")
        guard rel.count > 0 else {
            return  relUrl
        }
        return relUrl + "?\(rel)"
    }
    /// 直接通过路径 和参数调整到 界面
    public func openURL( _ param:[String:String]? = nil) -> Bool {
        let that = self.removingPercentEncoding ?? self
        /// 为了使html的文件通用 需要判断是否以http或者https开头
        guard that.hasPrefix("http") || that.hasPrefix("https") || that.hasPrefix("\(Navigator.scheme )://") else {
            var url = ""
            ///如果以 '/'开头则需要加上本服务域名
            if that.hasPrefix("/") {
                url = UtilCore.sharedInstance.baseUrl + that
            }else{
                url = that.getUrlStr(param: param)
            }
            // 首先需要判断跳转的目标是否是界面还是处理事件 如果是界面需要: push 如果是事件则需要用:open
            let isPushed = Navigator.that?.push(url) != nil
            if isPushed {
                return true
            } else {
                return (Navigator.that?.open(url)) ?? false
            }
        }
        // 首先需要判断跳转的目标是否是界面还是处理事件 如果是界面需要: push 如果是事件则需要用:open
        let isPushed = Navigator.that?.push(that) != nil
        if isPushed {
            return true
        } else {
            return (Navigator.that?.open(that)) ?? false
        }
    }
}
```
使用的时候非常方便,比如要跳转到:`https://www.jianshu.com/`
```swift
_ = "https://www.jianshu.com/".openURL()
```
