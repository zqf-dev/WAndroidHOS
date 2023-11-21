import webview from '@ohos.web.webview'
import router from '@ohos.router'
import { Constants } from '../utils/Constants'

@Entry
@Component
struct DetailsWeb {
  webController: WebviewController = new webview.WebviewController()
  @State url: string = router.getParams()?.['url']

  build() {
    Column() {
      Web({ src: this.url, controller: this.webController }) {
      }.onErrorReceive((error) => {
        // 网页加载遇到错误时触发该回调
        console.log(Constants.TAG, error.request)
      })
      .onHttpErrorReceive((httpError) => {
        //网页加载资源遇到的HTTP错误（响应码>=400)时触发该回调
        console.log(Constants.TAG, httpError.request)
      }).onPageBegin((event)=>{
        //网页开始加载时触发该回调，且只在主frame触发，iframe或者frameset的内容加载时不会触发此回调
        console.log(Constants.TAG, event.url)
      })
    }
    .width('100%')
    .height('100%')
  }
}