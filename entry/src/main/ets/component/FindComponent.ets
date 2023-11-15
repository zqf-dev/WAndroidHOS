import { Constants } from '../utils/Constants';

@Component
export struct Find {

  build() {
    Navigation() {

    }
    .title(Constants.SQUARE_TITLE)
    .titleMode(NavigationTitleMode.Full)
    .hideToolBar(true)
    .hideBackButton(true)
    .backgroundColor('#fff')
  }
}