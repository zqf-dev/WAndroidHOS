import router from '@ohos.router'
import hilog from '@ohos.hilog'

@Entry
@Component
struct Launch {
  @State message: string = 'WanAndroid HarmonyOS'

  jumpToMain() {
    setTimeout(() => {
      router.replaceUrl({ url: 'pages/Index' })
    }, 2000)
  }

  aboutToAppear() {
    hilog.info(0x011, 'Tag', 'aboutToAppear')
  }

  aboutToDisappear() {
    hilog.info(0x011, 'splash', 'aboutToDisappear')
  }

  onPageShow() {
    this.jumpToMain()
    hilog.info(0x011, 'splash', 'onPageShow')
  }

  onPageHide() {
    hilog.info(0x011, 'splash', 'onPageHide')
  }

  onBackPress() {
    hilog.info(0x011, 'splash', 'onBackPress')
  }

  build() {
    Flex({
      justifyContent: FlexAlign.Center,
      alignItems: ItemAlign.Center
    }) {
      Text(this.message).fontSize(50)
    }.width('100%')
    .height('100%')
  }
}