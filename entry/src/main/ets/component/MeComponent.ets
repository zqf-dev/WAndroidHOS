import { Constants } from '../utils/Constants';

@Component
export struct Me {

  build() {
    Navigation() {

    }
    .title(Constants.ME_TITLE)
    .titleMode(NavigationTitleMode.Full)
    .hideToolBar(true)
    .hideBackButton(true)
    .backgroundColor('#fff')
  }
}