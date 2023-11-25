import router from '@ohos.router'
import hilog from '@ohos.hilog'
import { Constants } from '../utils/Constants'

@Entry
@Component
struct Launch {
  @State message: string = '玩Android\nHarmonyOS版'

  jumpToMain() {
    setTimeout(() => {
      router.replaceUrl({ url: 'pages/Index' })
    }, 2000)
  }

  aboutToAppear() {
    this.jumpToMain()
    hilog.info(0x011, 'Tag', 'aboutToAppear')
  }

  onPageShow() {
    hilog.info(0x011, 'splash', 'onPageShow')
  }

  build() {
    Flex({
      alignItems: ItemAlign.Center,
      direction: FlexDirection.Column
    }) {
      Stack() {
        Text(this.message)
          .fontSize(30)
          .width(200)
          .textAlign(TextAlign.Center)
          .margin({ top: px2vp(300) })
          .fontColor($r('app.color.font_color_white'))
          .lineHeight(40)
      }.height('97%').alignContent(Alignment.TopStart)

      Text('https://github.com/zqf-dev')
        .fontColor($r('app.color.font_color_white'))
        .width('100%')
        .fontSize(px2vp(30))
        .textAlign(TextAlign.Center)
    }
    .linearGradient({
      direction: 180,
      repeating: false,
      colors: [['#FF03DAC5', 0.0], ['#55C7FB', 1]]
    })
    .width(Constants.FULL_PERCENT)
    .height(Constants.FULL_PERCENT)
  }
}