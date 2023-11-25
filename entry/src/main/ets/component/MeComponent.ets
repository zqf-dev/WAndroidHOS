import Prompt from '@system.prompt';
import router from '@ohos.router';
import { MeListBean } from '../model/MeListBean';
import { Constants } from '../utils/Constants';
import preferences from '@ohos.data.preferences';
import EntryAbility from '../entryability/EntryAbility';

@Component
export struct Me {
  build() {
    Column() {
      Column() {
        Image($r('app.media.ic_avatar')).width(80)
          .margin({ top: 60, bottom: 10 })
        Text('去登录').fontSize(18).fontColor($r('app.color.font_color_white'))
          .onClick(() => {
            router.pushUrl({
              url: 'pages/Login'
            })
          })
      }
      .backgroundColor($r('app.color.launch_bg_color'))
      .width(Constants.FULL_PERCENT)
      .height(200)

      List() {
        ForEach(Constants.MeListData, (item: MeListBean, index) => {
          ListItem() {
            Flex({ justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
              Row() {
                Image(item.img).width(28)
                Text(item.name).margin({ left: 10 })
              }

              Image($r('app.media.right')).width(30)
            }
          }
          .padding({ left: 20, right: 20 })
          .width(Constants.FULL_PERCENT)
          .height(55)
          .onClick(() => {
            Prompt.showToast({ message: '点击了' + item.name })
          })
        })
      }
      .width(Constants.FULL_PERCENT)
      .height(Constants.FULL_PERCENT)
      .divider({
        color: $r('app.color.line_color'),
        strokeWidth: Constants.Article_LIST_DIVIDER_STROKE_WIDTH,
        endMargin: Constants.Article_LIST_MARGIN_RIGHT
      })
    }
    .height(Constants.FULL_PERCENT)
  }
}