import HashMap from '@ohos.util.HashMap'
import Prompt from '@system.prompt'
import router from '@ohos.router'
import { userLogin } from '../request/Login'
import { preferences } from '../entryability/EntryAbility'
import { Constants } from '../utils/Constants'

@Entry
@Component
struct Login {
  @State acc: string = ""
  @State pwd: string = ""
  params: HashMap<string, Object> = new HashMap();

  login() {
    this.params.set('username', this.acc)
    this.params.set('password', this.pwd)
    userLogin(this.params).then((data: any) => {
      if (data) {
        try {
          //用户id
          preferences.put("id", data.id)
          //用户名
          preferences.put("username", data.username)
          //昵称
          preferences.put("nickname", data.nickname)
          //等级
          preferences.put("coinCount", data.coinCount)
          //用户信息
          preferences.put("userinfo", JSON.stringify(data))
          let promise = preferences.flush()
          promise.then(() => {
            console.log(Constants.TAG, "Succeeded in flushing.");
          }).catch((err) => {
            console.log(Constants.TAG, "Failed to flush. code =" + err.code + ", message =" + err.message);
          })
        } catch (e) {
          e.message
        }
        Prompt.showToast({ message: '登录成功' })
        router.back()
      }
    }).catch((err: string | Resource) => {
      Prompt.showToast({ message: err.toString() })
    })
  }

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
          }).type(InputType.Normal).onChange((value) => {
            this.acc = value;
          })
        }

        Flex({
          justifyContent: FlexAlign.SpaceBetween,
          alignItems: ItemAlign.Center
        }) {
          Text('密码：').width('20%')
          TextInput({
            placeholder: '请输入密码'
          }).type(InputType.Password)
            .onChange((value) => {
              this.pwd = value;
            })
        }.margin({ top: 20 })

        Button('登录').width('100%').margin({ top: 30 })
          .onClick(() => {
            //点击
            this.login()
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