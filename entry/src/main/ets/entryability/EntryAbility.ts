import UIAbility from '@ohos.app.ability.UIAbility';
import hilog from '@ohos.hilog';
import window from '@ohos.window';
import data_preferences from '@ohos.data.preferences';

export let preferences = null

export default class EntryAbility extends UIAbility {
  onCreate(want, launchParam) {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
  }

  onDestroy() {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage) {
    // 主窗口已创建，为此功能设置主页面
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');
    try {
      data_preferences.getPreferences(this.context, 'myStore', function (err, val) {
        if (err) {
          console.error("Failed to get preferences. code =" + err.code + ", message =" + err.message);
          return;
        }
        preferences = val;
        console.info("Succeeded in getting preferences.");
        preferences.get('token', '456', (value) => {
          console.info("token" + value)
        })
      })
    } catch (err) {
      console.error("Failed to get preferences. code =" + err.code + ", message =" + err.message);
    }
    try {
      // TODO 加载页面的入口
      windowStage.loadContent('pages/Launch', (err, data) => {
        if (err.code) {
          hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
          return;
        }
        hilog.info(0x0000, 'testTag', 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
      });
    } catch (err) {
      hilog.info(0x0000, 'testTag', 'Failed loadContent' + err);
    }
  }

  onWindowStageDestroy() {
    // 主窗口被破坏，释放UI相关资源
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground() {
    // Ability 处于前台
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground() {
    // Ability 处于后台
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
