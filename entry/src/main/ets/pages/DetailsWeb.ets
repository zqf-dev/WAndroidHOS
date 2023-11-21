import webview from '@ohos.web.webview'
import router from '@ohos.router'
import { Constants } from '../utils/Constants'

@Entry
@Component
struct DetailsWeb {
  webController: WebviewController = new webview.WebviewController()
  @State url: string = router.getParams()?.['url']

  build() {
    Column(){
      Web({ src: this.url, controller: this.webController })
    }
  }
}