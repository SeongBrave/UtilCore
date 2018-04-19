//
//  Web_Vc.swift
//  Pods
//
//  Created by eme on 2017/1/17.
//
//

/*
 owner:cy
 update:2016年11月14日09:34:13
 info: web界面
 */
import RxSwift
import ModelProtocol
import WebViewJavascriptBridge
import SwiftyJSON

public class Web_Vc: Base_Vc {
    
    /****************************Storyboard UI设置区域****************************/
    
    @IBOutlet weak var web_Wb: UIWebView!
    public var bridge:WebViewJavascriptBridge?
    /*----------------------------   自定义属性区域    ----------------------------*/
   public var isReload:Bool = false
   public var webUrl:String?
   public var webTitle:String?
   public var isloading:Bool = true
    /****************************Storyboard 绑定方法区域****************************/
    
    
    
    /**************************** 以下是方法区域 ****************************/
    override public func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
//        if self.isReload {
//            self.web_Wb.reload()
//            self.isReload = false
//        }
        self.loadWebView()
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    override public func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier { // 检查是否 nil
            switch identifier {
            default: break
            }
        }
    }
    /**
     界面基础设置
     */
    override public func setupUI() {
        self.tabBarController?.tabBar.isHidden = true
        /// 禁止twebview长按
        //        self.web_Wb.dataDetectorTypes = UIDataDetectorTypes.link
        WebViewJavascriptBridge.enableLogging()
        self.bridge = WebViewJavascriptBridge(forWebView: self.web_Wb)
        self.bridge?.setWebViewDelegate(self)
        //打开原生界面（商品详情）
        self.bridge?.registerHandler("openbyuri", handler:{  data , response in
            let rel = data as? Dictionary<String,String>
            if let rel = rel{
                if let uri = rel["uri"]{
                    _ = uri.openURL()
                }
            }
        })
        self.bridge?.registerHandler("getactivedata", handler:{  data , response in
            guard let response = response else{
                return
            }
            UtilCore.sharedInstance.activeData[UtilCore.sharedInstance.fieldValue] = UtilCore.sharedInstance.activeid
            response(UtilCore.sharedInstance.activeData)
        })
        self.bridge?.registerHandler("error", handler:{  data , response in
            if let data = data{
                let json = JSON(data)
                let message = json["message"].stringValue
                let status = json["status"].intValue
                if status == 500103{
                    self.isReload = true
                }
                self.view.toastError(MikerError("status", code: status, message: message))
            }
        })
        //服务器加载完毕后 需要关闭遮罩
        self.bridge?.registerHandler("closeLoading", handler:{  data , response in
            self.view.hideLoading()
        })
        /**
         *  自定义 导航栏左侧 返回按钮
         */
        self.customLeftBarButtonItem()
        if let title = self.webTitle {
            self.title = title
        }
//        self.loadWebView()
    }
    /// 加载网页
   public func  loadWebView() {
        if let webUrl = self.webUrl {
            var retUrl = URL(string: webUrl)
            if retUrl == nil{
                guard let encodeUrl = webUrl.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else{
                    return
                }
                retUrl = URL(string: encodeUrl)
            }
            guard let url = retUrl else { return  }
            let request = NSMutableURLRequest(url: url)
            if self.isloading {
                self.view.showLoading()
            }
            setHttpCookies(url)
            request.setValue(UtilCore.sharedInstance.activeid, forHTTPHeaderField:UtilCore.sharedInstance.fieldValue)
            self.web_Wb.loadRequest(request as URLRequest)
        }
    }
    
    /**
     绑定到viewmodel 设置
     */
    override public func bindToViewModel(){
        
    }
    /**
     自定义返回上级界面
     */
    override public func backToView()  {
        if self.web_Wb.canGoBack {
            self.web_Wb.goBack()
        }else{
            _ = self.navigationController?.popViewController(animated: true)
        }
        
    }
    //设置cookie
    public func  setHttpCookies(_ url:URL) {
        //创建一个HTTPCookie对象
        var props:[HTTPCookiePropertyKey:Any] = [:]
        props[HTTPCookiePropertyKey.name] = UtilCore.sharedInstance.fieldValue
        props[HTTPCookiePropertyKey.value] = UtilCore.sharedInstance.activeid
        props[HTTPCookiePropertyKey.path] = url.path
        props[HTTPCookiePropertyKey.domain] = url.host
        //90天后过期
        //如果没有设置 Cookie 失效时间，程序退出后这个 Cookie 是不会自动保存的。如果想要持久化 Cookie，给它设置个失效时间，这样下次启动 app 该 Cookie仍然存在
        // props[HTTPCookiePropertyKey.expires] = Date().addingTimeInterval(3600*24*90)
        guard let cookie = HTTPCookie(properties: props) else {
            return
        }
        //通过setCookie方法把Cookie保存起来
        HTTPCookieStorage.shared.setCookie(cookie)
    }
}
extension Web_Vc:UIWebViewDelegate{
    
   public func webViewDidStartLoad(_ webView: UIWebView){
        
    }
    
   public func webViewDidFinishLoad(_ webView: UIWebView){
        if self.webTitle  == nil {
            self.title = webView.stringByEvaluatingJavaScript(from: "document.title")
        }
        if self.isloading {
            self.view.hideLoading()
        }
    }
   public func webView(_ webView: UIWebView, didFailLoadWithError error: Error){
        if self.isloading {
            self.view.hideLoading()
        }
    }
}
