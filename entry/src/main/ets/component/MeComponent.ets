import Prompt from '@system.prompt';
import router from '@ohos.router';
import { MeListBean } from '../model/MeListBean';
import { Constants } from '../utils/Constants';
import { preferences } from '../entryability/EntryAbility'
import picker from '@ohos.file.picker';

@Component
export struct Me {
  @State name: string = ''
  @State avatar: string[] = []

  aboutToAppear() {
    let pf = preferences.get('username', '');
    pf.then((data) => {
      this.name = data.toString()
    }).catch((err) => {
      console.log(Constants.TAG, err)
    })
  }

  build() {
    Column() {
      Column() {
        Image(this.avatar.length > 0 ? this.avatar[0] : $r('app.media.ic_avatar')).width(80)
          .margin({ top: 60, bottom: 10 })
          .borderRadius(100)
          .onClick(() => {
            //选择器使用
            let selectOptions = new picker.PhotoSelectOptions()
            //选择的类型 IMAGE_TYPE:图片 VIDEO_TYPE:视频 IMAGE_VIDEO_TYPE:所有
            selectOptions.MIMEType = picker.PhotoViewMIMETypes.IMAGE_TYPE
            selectOptions.maxSelectNumber = 1
            let photoView = new picker.PhotoViewPicker()
            photoView.select(selectOptions, (err, result) => {
              if (err) {
                console.log("err: " + err);
                return
              }
              this.avatar = [...result.photoUris]
            })
          })
        Text(this.name ? this.name : '去登录').fontSize(18).fontColor($r('app.color.font_color_white'))
      }
      .onClick(() => {
        if (this.name) return
        router.pushUrl({
          url: 'pages/Login'
        })
      })
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