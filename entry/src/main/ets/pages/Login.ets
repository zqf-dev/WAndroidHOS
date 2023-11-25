import { preferences } from '../entryability/EntryAbility'
import { Constants } from '../utils/Constants'

@Entry
@Component
struct Login {
  build() {
    Navigation() {
      Flex({
        direction: FlexDirection.Row,
        wrap: FlexWrap.Wrap,
      }) {
        Flex({
          justifyContent: FlexAlign.SpaceBetween,
          alignItems: ItemAlign.Center
        }) {
          Text('账号：').width('20%')
          TextInput({ placeholder: '请输入账号'
          }).type(InputType.PhoneNumber)
        }

        Flex({
          justifyContent: FlexAlign.SpaceBetween,
          alignItems: ItemAlign.Center
        }) {
          Text('密码：').width('20%')
          TextInput({
            placeholder: '请输入密码'
          }).type(InputType.Password)
        }.margin({ top: 20 })

        Button('登录').width('100%').margin({ top: 30 })
          .onClick(() => {
            //点击
          })
      }
      .padding(20)
      .width('100%')
      .height('100%')
    }
    .title('登录')
    .hideToolBar(false)
    .titleMode(NavigationTitleMode.Mini)
  }
}