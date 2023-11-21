import webview from '@ohos.web.webview'
import router from '@ohos.router'

@Entry
@Component
struct DetailsWeb {
  webController: WebviewController = new webview.WebviewController()
  @State url: string = router.getParams()?.['url']

  build() {
    Column() {
      Web({ src: this.url, controller: this.webController }) {
      }
    }
    .width('100%')
    .height('100%')
  }
}